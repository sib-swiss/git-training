# Exercise solutions - Git optional modules - Git submodules

**Table of Content:**

[[_TOC_]]

<br>

:pushpin:  
**Note:** in these corrections, `git switch` is used to checkout/switch
branches. If you are using a Git version older than `2.23`, `git checkout`
should be used instead.
Similarly, `git switch -c` (create + switch branch) must be replaced by
`git checkout -b`.

<br>
<br>


## Exercise 1 - The Git reference web page gets better with submodules

### A) Clone the projects - including their submodule
To get the actual content of the submodules, it is not enough to simply make a
`git clone`: the submodules must also be initialized and updated.

There are 3 different methods to do this:
1. Use `git clone --recurse-submodules <repo URL>`
   (this is the method you want to use most of the time).
2. Clone the repo, then use `git submodule update --init --recursive`.
3. Clone the repo, then initialize the submodules with `git submodule init`,
   then update the submodules with `git submodule update`.

These 3 options are illustrated here:
```yaml
cd exercise_5

# Option 1:
git clone --recurse-submodules https://github.com/sibgit/git_resources_webpage.git
git clone --recurse-submodules https://github.com/sibgit/useful-tools.git

# Option 2:
git clone https://github.com/sibgit/git_resources_webpage.git
git clone https://github.com/sibgit/useful-tools.git
cd git_resources_webpage
git submodule update --init --recursive
cd ../cd useful-tools
git submodule update --init --recursive

# Option 3: same as option 2, using individual "init" and "update" commands
# instead of the "update --init" shortcut.
git submodule init
git submodule update

# Print the content of .gitmodules to the terminal.
cat .gitmodules
```

:question:
**Question answer**:
* The command to update the content of the *git_resources_webpage* and
  *useful-tools* repositories (so that changes also affect submodules) is
  given below.
* The command must be run in the main project (the super-project) - not in
  the *glitter-cursor* subdirectory!
    ```yaml
    git pull --recurse-submodule
    ```

<br>

### B) Change the style of the web sites by adding a submodule

1. First we need to fork https://github.com/sibgit/great-style from the GitHub
   web interface into our own account. This is so that we own the repo and can
   push changes to it.

2. Add the *great-style* repo as a submodule to our two projects. The commands
   are the same for both *git_resources_webpage* and *useful-tools*.
    ```yaml
    git submodule add https://github.com/<your-github-username>/great-style.git
    ```

3. Commit the changes. Note that both `great-style` and `.gitmodules` have
   already been automatically been staged by Git.
    ```yaml
    git commit -m "Add great-style submodule"
    ```

4. Looking at the content of `.gitmodules`, we now see that a second submodule,
   *great-style*, was added.
    ```yaml
    cat .gitmodules
    [submodule "glitter-cursor"]
        path = glitter-cursor
        url = https://github.com/sibgit/glitter-cursor.git
        branch = main
    [submodule "great-style"]
        path = great-style
        url = https://github.com/<your-github-username>/great-style
    ```

   :pushpin:
   **Note:** to see the commit to which our submodules are pointing, we can
   use:
    ```yaml
    git submodule status

    # Or we could also run a command like:
    git submodule foreach "git log --oneline"
    ```

<br>

### C) Improve the great-style submodule

1. Enter the submodule and make edits to the `great_style.css` file like you
   would in a normal Git repository.
    ```yaml
    cd git_resources_webpage/great-style
    vim great_style.css                   # On line 4, change --anim-cicle-time from 1s to 10s
    ```

2. Commit the changes in the *great-style* submodule and push them to the
   remote.
    ```yaml
    git add great_style.css
    git commit -m "Slow down font color shift loop to 10s"
    git push
    ```

3. Update the *git_resources_webpage* repository (the super-project) so that
   it points at the latest version of *great-style*.
    ```yaml
    cd ..                      # Move to the parent directory.
    git diff --submodule=diff  # Display the actual changes (like a git diff) in the submodule.

    # Commit the new version of great-style to the super-project:
    git add great-style
    git commit -m "Update great-style submodule with slowed-down color changes"
    ```

   :question:
   **Question answer:** as we do not have permission to write to the
   *git_resources_webpage* remote, we cannot push our changes to the
   super-project. But if we did, the command would be:
    ```yaml
    git push --recurse-submodules=on-demand
    ```

### Additional tasks (if you have time)

4. We can now update our second project, *useful-tools*, with the new version
   of *great-style*.
   There are 2 ways to get the new changes from *great-style* into the
   submodule of our local `useful-tools` repo:
    * **Option 1:** pull the changes manually:
        ```yaml
        # Enter the submodule.
        cd useful-tools/great-style

        # Pull new updates on "main". You should in principle already be on
        # branch "main", but if not, switch to it: git switch main
        git pull
        ```
    * **Option 2:** use `git submodule update --remote` (must be run in the
      super-project).
        ```yaml
        cd useful-tools/
        git submodule update --remote
        ```

      :pushpin:
      **Note:** if the pull on the `main` branch does not work automatically,
      we need to edit the `.gitmodules` file and add `branch = main` for the
      *great-style* submodule, like so:
        ```text
        [submodule "great-style"]
            path = great-style
            url = https://github.com/<github-username>/great-style
            branch=main
        ```

   After *great-style* is updated to its latest version, we can now commit the
   change in the super-project *useful-tools*.
    ```yaml
    git diff --submodule
    git add great-style
    git commit -m "Update great-style submodule with slowed-down color changes"
    ```


<br>
<br>
<br>
