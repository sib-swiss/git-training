# Optional module exercises - Git submodules

**Table of Content:**

[[_TOC_]]

<br>
<br>

## Exercise 1 - The Git reference web page gets better with submodules [45 min]
**Objective:** introduction to git submodule.

In this exercise, we will implement some improvements to two web pages using
Git **submodules**.  
The projects for these web pages are the following:
* The [git resource webpage](https://github.com/sibgit/git_resources_webpage),
  which you might remember from the *Version Control with Git – First Steps*
  exercises.
* The [useful tools webpage](https://github.com/sibgit/useful-tools), a page
  that shows a list of useful tools for the part of our lives that does not
  involve typing Git commands in a shell (so most of our lives, hopefully!).

<br>

### A) Clone the projects - including their submodule

1. Change into the `exercise_submodules` directory - it should be empty.
2. Clone the repositories for the 2 web pages (links above). These repositories
   contain submodules, so **make sure to also download the submodule content**.
3. Display the two web-pages `references.html` and `useful-tools.html` in your
   local browser (one is in each of the repo you just cloned). They should both
   show a *glitter effect* when moving the mouse pointer.
4. Have a look at `.gitmodules` to see what submodules are in these projects.

:question:
**Questions**:
* Which command would you use to update the content of the
  `git_resources_webpage` and `useful-tools` repositories (so that changes
  also affect submodules)?
* Where would you need to run this command? In the main project (e.g.
  `git_resources_webpage`) or inside the `glitter-cursor` submodule directory?

<br>

### B) Change the style of the web sites by adding a submodule

1. **Go to [the great-style GitHub page](https://github.com/sibgit/great-style)**
   in your browser and create a **Fork** of the project. To create a fork,
   click on the **Fork** button, near the top right of the project's GitHub
   web page.

   This will create **a copy** of the original project under your GitHub/GitLab
   account. You will be the **owner** of this forked project, and therefore you
   will be able to push commits to it (which you don't have permission to do on
   the original project).

2. Add the **forked** *great-style* repo as a new submodule to both
   `git_resources_webpage` and `useful-tools`.  
   :fire:
   **Important:** make sure to use the **forked** project, and *not* the
   original project!

3. **Refresh the two web pages** in your browser, they should now have another
   style. If the new style is working as expected, **commit the changes**
   (i.e. the addition of the new submodule) in your two local repos
   (`git_resources_webpage` and `useful-tools`) with the commit message:
   `"Add great-style submodule"`.

4. Have again a look at the `.gitmodules` files to see how they changed.

<br>

### C) Improve the great-style submodule
If you look at your web pages, you can notice that the colors of the hyperlinks
change rather quickly, to the point where we cannot enjoy this fabulous great
style to its full extent. So let's slow that down a bit.

We will first do the changes from within the project `git_resources_webpage`
and then pull the latest version of the submodule in `useful-tools`.

1. **Open the file `git_resources_webpage/great-style/great_style.css`** in a
   text editor, and change the `--anim-cicle-time` value to 10s (line 4 of
   file).  
   Reload the web page `references.html` in your browser, and verify that the
   colors now change more slowly.

   Wait... did we just make a great style even greater? *Yes, we did !* :rainbow:

2. Let's keep these changes for posterity by committing them to the
   `great_style` submodule and then pushing them to the remote (your forked
   *great-style* remote).  

   :bomb:
   **Pitfall:** if you get a message telling you that you are not allowed to
   push, then it's probably because you have added the original *great-style*
   project as a remote, and not your forked version.

3. Almost done! All that is left to is to update the *git_resources_webpage*
   repository (the super-project) so that it points at the new version of
   *great-style* that we just committed.

   Go back to the root of `git_resources_webpage`, and commit the changes (the
   update in the version of the *great-style* submodule) with the message
   `"Update great-style submodule with slowed-down color changes"`  

   :question:
   **Question**: in the current setup, you cannot push the changes in
   `git_resources_webpage` to the remote repo because you do not have write
   permission on it. However, if you did, what would be the command to push
   your changes in both *git-resources* and its submodules all at once?

<br>

### Additional tasks (if you have time)

4. Finally, you should now update the *great-style* submodule also in your
   local `useful-tools` repository:
    * Enter the `useful-tools` repo and get the new version of the
      *great-style* submodule.
    * Reload the page *useful-tools.html* in your browser and verify that the
      colors now also change more slowly.
    * Commit your changes.


<br>
<br>
<br>
