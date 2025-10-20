# Version control with Git

Welcome to the home page of the **Version control with Git** SIB course.

This two-day course provides a **comprehensive overview** of the
**[Git version control](https://git-scm.com)** system. Please see the
[course description](#course-description-) section for details.

<br>

## Setting-up your environment 🐣

* Please complete the [environment setup instructions](doc/environment_setup.md)
  **before** the start of the course.  
* In particular, make sure to communicate us your
  **GitHub user name at least 2 days before** the start of the course via
  the course shared online document (link will be sent by email before the
  course).

<br>

## Course material 📚

**Please note** that the definitive course material (slides and exercises)
will be made available on the first day of the course. Until then files do not
necessarily correspond to their final version (but are in principle very close
to it).

✨ **Tip:** to download the entire course material in one go, you can clone
this repository by running the git command:

```sh
git clone https://github.com/sib-swiss/git-training.git
```

### Course slides

* Day 1: [First steps with Git](slides/slides_git_first_steps.pdf)
* Day 2: [Git advanced topics](slides/slides_git_advanced_topics.pdf)
* Git commands: a summary of all commands seen during the course. Available
  as [PDF document](doc/git_command_summary.pdf),
  and [markdown](doc/git_command_summary.md) for online viewing.
* [Git optional modules](slides/slides_git_optional_modules.pdf). These are
  more specialized Git commands and features that go beyond the scope of the
  course and will not be covered in class but can be discussed upon request.

### Exercise instructions

Exercise instructions are best viewed in a web browser. Simply click on the
link below to display them.

* Day 1: [exercises first steps](exercises/exercises_first_steps.md)
* Day 2: [exercises advanced topics](exercises/exercises_advanced_topics.md)
* Optional modules (not covered in class):
  * [optional exercise CI/CD](exercises/exercises_optional_cicd.md)
  * [optional exercise submodules](exercises/exercises_optional_submodules.md)
  * [optional exercise Git LFS](exercises/exercises_optional_LFS.md)

### Exercise material

Please download the following `.zip` files and decompress them on your local
machine.

* Day 1: [exercises_first_steps.zip](exercises/exercises_first_steps.zip)
* Day 2: [exercises_advanced.zip](exercises/exercises_advanced.zip)
* Optional modules (not covered in class):
  [exercises_optional_modules.zip](exercises/exercises_optional_modules.zip)

### Exercise solutions

The solutions to all exercises are provided here. Nevertheless, we encourage
you to **not look at the solutions too quickly**, and try to solve the
exercises without them. Remember that you can always ask the course teachers
for help.

* Day 1: [solutions first steps](exercises/solutions_first_steps.md)
* Day 2: [solutions advanced topics](exercises/solutions_advanced_topics.md)
* Optional modules:
  * Solutions CI/CD - solutions are integrated in the exercise instructions.
  * [Solutions submodules](exercises/solutions_optional_submodules.md)
  * [Solutions Git LFS](exercises/solutions_optional_LFS.md)

<br>

## Useful references and tutorials 🔮

* [Pro Git - free Git book](https://git-scm.com/book/en/v2)
* [Atlassian Git tutorials](https://www.atlassian.com/git/tutorials)

<br>

## Course schedule ⏳

* **Day 1 and 2:** 9h00 - 17h30.
* 1 hour **lunch break**, usually 12h00 - 13h00.
* 15 minutes breaks in each half-day session.

<br>
<br>

## Course Description 🦉

### Overview

[**Git**](https://git-scm.com) is an open source **version control system** for
tracking changes in code and other types of text documents. First released in
2005, Git has become the **de-facto standard** for version control, and is
extensively used in both open source and commercial software development.
Beyond software development, Git has also proven to be an essential tool in
**reproducible research** - allowing to keep track of files such as data
analysis scripts, pipelines, reports or more generally any text-based document.

This **2-days course** gives a **comprehensive overview of Git** and its most
useful commands, as well as an introduction to collaborative workflows using
[**GitHub**](https://github.com) through both theory and practical exercises.

The course starts with the basics of Git - it is therefore suitable for people
with no or little knowledge of Git - and will take participants all the way
into more advanced territory such as editing the history of a Git repository.
Emphasis is also put on collaborative workflows, which are actively practiced
in some of the practical exercises.

**Important:** please note that this course focuses exclusively on using Git
via **command line**. This knowledge is then easily transferrable to any GUI
environment (e.g. VS Code, RStudio, etc.).

The course covers the following topics:

#### Day 1: first steps with Git

* Brief introduction to version control systems and Git.
* Git basics: creating a Git repository and making commits.
* Git concepts: commits, the `HEAD` pointer and the Git index.
* Git branches: introduction to branched workflows and collaborative
  workflow examples.
* Branch management: merge, rebase and cherry-pick.
* Retrieving data from the Git database: `git checkout`.
* Working with remotes: collaborating with Git and GitHub.

#### Day 2: Git advanced topics

* Rewriting history: interactive rebase, git reset and commit amending.
* The detached `HEAD` state explained.
* The Git stash.
* Git tags: label important commits.
* GitHub: creating new projects, adding users and collaborating with them.

#### Optional modules

This material is not formally presented during the course. It covers topics
that can be useful in certain scenarios:

* **GitHub Actions** and **GitLab CI/CD**: writing automated pipelines.
* **Git submodules**: embed a Git repository as a subdirectory of another Git
  repo.
* **Git LFS**: versioning large files with Git.

### Audience

This course is aimed at people who are interested in using a version control
system for collaborative work, or simply to keep track of modifications in
their scripts, files or code base.  
This includes people working on code development, but also scientists
interested in improving the reproducibility of their data analyses by keeping
track of their scripts using version control.

### ECTS credits

Participants who wish to receive ECTS credits for the course can take an
optional exam at the end of day 2 of the course. The SIB will recommend
successful participants to receive 0.5 ECTS credits from their home
institutions.

<br>

## Course prerequisites 🌅

### Knowledge/competencies

The course is focused on using Git in command line mode (no graphical user
interface). It is therefore
**highly recommended to have some basic knowledge of the UNIX command line**:
e.g. how to change directory or how to edit a file in a command line editor
such as `vim`/`nano`.

If you are not familiar with these UNIX fundamentals, we strongly recommend
that you either:

* Follow an introductory UNIX course (e.g. the SIB "First Steps with UNIX"
  course - see [upcoming training courses](https://www.sib.swiss/training/upcoming-training-courses),
* Take an online tutorial such as
  [this one](https://edu.sib.swiss/pluginfile.php/2878/mod_resource/content/4/couselab-html/content.html)
  before the start of the course.

### Technical

* A Wi-Fi enabled laptop with a recent version of Git installed. Git is
  available on all major platforms and can be
  [downloaded here](https://git-scm.com/download).
* For online classes, you should also have a working microphone, as some
  exercises involve collaboration/communication with other participants.

<br>

## Acknowledgments and funding 💸

### Funding

* The development of this course has been funded by the Swiss State Secretariat
  for Education, Research and Innovation
  ([SERI](https://www.sbfi.admin.ch/sbfi/en/home.html)) trough the
  [SIB Swiss Institute of Bioinformatics](https://www.sib.swiss).
* Other funding sources include:
  * European Union's Horizon Europe Framework Program (grant number 101080997).
