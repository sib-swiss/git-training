#!/usr/bin/env bash
#
# Build a PDF version of the Git command summary.
#
# The primary format of the command summary is the markdown file, displayed on
# GitHub. This script is only needed if a PDF version is wanted (e.g. to print).
#
# Requirements: pandoc and a LaTeX distribution that provides xelatex.
# Usage:
#  > ./build_command_summary_pdf.sh                # Default output name: git_command_summary.pdf
#  > ./build_command_summary_pdf.sh [output file]  # Custom output file name.
#
# Note: the emojis used in the labels (e.g. "⚠️ Warning") are not available in
# the default LaTeX font, and are left out of the PDF (pandoc prints a warning).

set -euo pipefail

script_dir="$(cd "$(dirname "$0")" && pwd)"
input_file="${script_dir}/git_command_summary.md"
output_file="${1:-${script_dir}/git_command_summary.pdf}"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

# Lua filter that:
# * Replaces blocks of 3 (or more) "<br>" lines with a LaTeX "\bigskip".
#   Blocks with fewer "<br>" lines are removed.
# * Highlights the code blocks. This replaces pandoc's own syntax highlighting,
#   which (in older versions of pandoc) does not recognize comments placed
#   after a command. Comments, quoted strings and "<", ">" are highlighted with
#   the colors of pandoc's "tango" style (defined in the LaTeX header below).
# * Removes the content placed between "<!-- github-only -->" and
#   "<!-- /github-only -->" comments (e.g. tips about the GitHub web interface).
lua_filter="${tmp_dir}/filter.lua"
cat > "$lua_filter" <<'EOF'
local latex_escapes = {
    ["\\"] = "\\textbackslash{}", ["{"] = "\\{", ["}"] = "\\}",
    ["|"] = "\\VerbBar{}", ["_"] = "\\_", ["&"] = "\\&", ["%"] = "\\%",
    ["#"] = "\\#", ["`"] = "\\textasciigrave{}", ["'"] = "\\textquotesingle{}",
    ["-"] = "{-}", ["~"] = "\\textasciitilde{}", ["^"] = "\\^{}",
    ["<"] = "\\textless{}", [">"] = "\\textgreater{}",
}

local function escape(text)
    return (text:gsub("[\\{}|_&%%#`'%-~^<>]", latex_escapes))
end

local function token(name, text)
    if text == "" then
        return ""
    end
    return "\\" .. name .. "Tok{" .. escape(text) .. "}"
end

-- Position of the "#" that starts a comment: at the start of the line or
-- after a whitespace, and not inside a quoted string.
local function comment_start(line)
    local quote = nil
    for i = 1, #line do
        local c = line:sub(i, i)
        if quote then
            if c == quote then
                quote = nil
            end
        elseif c == '"' or c == "'" then
            quote = c
        elseif c == "#" and (i == 1 or line:sub(i - 1, i - 1):match("%s")) then
            return i
        end
    end
    return nil
end

local function highlight_command(text)
    local out = {}
    local i = 1
    while i <= #text do
        local c = text:sub(i, i)
        if c == '"' or c == "'" then
            local j = text:find(c, i + 1, true) or #text
            table.insert(out, token("String", text:sub(i, j)))
            i = j + 1
        elseif c == "<" or c == ">" then
            table.insert(out, token("Operator", c))
            i = i + 1
        else
            local j = (text:find("[\"'<>]", i) or #text + 1) - 1
            table.insert(out, token("Normal", text:sub(i, j)))
            i = j + 1
        end
    end
    return table.concat(out)
end

function CodeBlock(el)
    local lines = {}
    local text = el.text:gsub("\n+$", "")
    for line in (text .. "\n"):gmatch("(.-)\n") do
        local pos = comment_start(line)
        if pos then
            table.insert(lines, highlight_command(line:sub(1, pos - 1))
                .. token("Comment", line:sub(pos)))
        else
            table.insert(lines, highlight_command(line))
        end
    end
    return pandoc.RawBlock("latex",
        "\\begin{Shaded}\n\\begin{Highlighting}[]\n"
        .. table.concat(lines, "\n")
        .. "\n\\end{Highlighting}\n\\end{Shaded}")
end

function RawBlock(el)
    if el.format ~= "html" then
        return nil
    end
    local rest, br_count = el.text:gsub("<br>%s*", "")
    if rest ~= "" then
        return nil
    end
    if br_count >= 3 then
        return pandoc.RawBlock("latex", "\\bigskip")
    end
    return {}
end

local function is_marker(block, marker)
    return block.t == "RawBlock" and block.format == "html"
        and block.text:match("^%s*<!%-%-%s*" .. marker .. "%s*%-%->%s*$")
end

function Pandoc(doc)
    local blocks = {}
    local skip = false
    for _, block in ipairs(doc.blocks) do
        if is_marker(block, "github%-only") then
            skip = true
        elseif is_marker(block, "/github%-only") then
            skip = false
        elseif not skip then
            table.insert(blocks, block)
        end
    end
    doc.blocks = blocks
    return doc
end
EOF

# LaTeX header that makes the title block and the table of contents more
# compact, so that the table of contents fits on the first page:
# * Author and date are displayed on a single line, in a smaller font.
# * The space before each section entry of the table of contents is set with
#   "\cftbeforesecskip" (reduce it if the table of contents no longer fits on
#   the first page).
# * The table of contents has no title ("Contents").
# * A page break is added after the table of contents.
# * Code blocks: environments and colors used by the Lua filter above (copied
#   from pandoc's "tango" style), with a smaller font so that lines of up to
#   100 characters fit in the page width.
# * Code (code blocks and inline code) uses the "Source Code Pro" font, which is
#   part of TeX Live. It is loaded by file name, because the fonts of TeX Live
#   are not always found by their font name.
latex_header="${tmp_dir}/header.tex"
cat > "$latex_header" <<'EOF'
\setmonofont[
  Extension=.otf,
  UprightFont=*-Regular,
  ItalicFont=*-RegularIt,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldIt,
  Scale=0.87,
]{SourceCodePro}

\usepackage{fancyvrb}
\usepackage{framed}
\newcommand{\VerbBar}{|}
\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\{\},fontsize=\small}
\definecolor{shadecolor}{RGB}{248,248,248}
\newenvironment{Shaded}{\begin{snugshade}}{\end{snugshade}}
\newcommand{\NormalTok}[1]{#1}
\newcommand{\CommentTok}[1]{\textcolor[rgb]{0.56,0.35,0.01}{\textit{#1}}}
\newcommand{\StringTok}[1]{\textcolor[rgb]{0.31,0.60,0.02}{#1}}
\newcommand{\OperatorTok}[1]{\textcolor[rgb]{0.81,0.36,0.00}{\textbf{#1}}}

\usepackage{titling}
\setlength{\droptitle}{-2em}
\pretitle{\begin{center}\LARGE\bfseries}
\posttitle{\par\end{center}\vspace{-0.5em}}
\preauthor{\begin{center}\small}
\postauthor{\ --\ \thedate\par\end{center}}
\predate{\setbox0=\hbox\bgroup}
\postdate{\egroup}

\usepackage{tocloft}
\setlength{\cftbeforesecskip}{1em}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{0pt}

\AtBeginDocument{%
  \let\oldtableofcontents\tableofcontents
  \renewcommand{\tableofcontents}{%
    \renewcommand{\contentsname}{}\oldtableofcontents\newpage}%
}
EOF

# "--shift-heading-level-by=-1" turns the "# Git command summary" heading into
# the title of the document, and the "##" headings into top-level sections.
pandoc "$input_file" \
    --from=gfm \
    --lua-filter="$lua_filter" \
    --include-in-header="$latex_header" \
    --pdf-engine=xelatex \
    --shift-heading-level-by=-1 \
    --toc \
    --toc-depth=2 \
    --no-highlight \
    --metadata=author:"Robin Engler" \
    --metadata=date:"$(date +%Y-%m-%d)" \
    --variable=geometry:margin=2.5cm \
    --output="$output_file"

echo "Built: ${output_file}"
