# Exercise solutions - Optional Git modules - Git LSF

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

## Exercise 1 - Create a new Git repository from scratch with Git LFS file tracking

1. Initialize a new Git repository and make a first commit that adds the
   `README.md` file:
    ```yaml
    cd exercise_lfs/test_lfs.git
    git init
    git add README.md
    git commit -m "First commit"
    ```

2. We start by telling Git LFS which files should be tracked. Then we add/stage
   all files and commit:
    ```yaml
    # Tell Git LFS which files its should track.
    git lfs track logo.png "*.fasta" "db/db_file.txt"

    # Stage all files and commit.
    git add --all
    git commit -m "Add all files to the Git repo"
    ```

   Based on the pattern we gave to the `git lfs track` command, Git will
   store the files either as regular files or as LFS files.

3. Verify that the correct files are being tracked.
    ```yaml
    git lfs ls-files
    #  d6c210aeaf * db/db_file.txt
    #  34804bc7cb * logo.png
    #  6f0a4add2f * sequences/sample_A.fasta
    #  efdc76ef2a * sequences/sample_B.fasta
    ```

   :pushpin:
   **Note:** to display the actual files in the LFS object store, we can use
   `ls -l .git/lfs/objects/*/*` or `tree .git/lfs/objects/`

4. :question:
   **Question answer:** since only a pointer/placeholder of the files tracked
   by Git LFS is stored in the Git database (the actual files are in the Git
   LFS cache), the `git show` command only shows the content of the pointer
   file, and not the content of the actual file.

5. :question:
   **Question answer:** for files tracked by Git LFS, `git diff` only shows the
   difference between the two versions of the pointer file, not the two
   versions of the file. Therefore it only displays the difference in hash
   value and in size between the two versions of a file.

<br>
<br>
<br>

## Exercise 2 - Migrate an existing directory to Git LFS [40 min]

1. Explore the `arctic_animals.git` repository. We can see that there are 2
   branches, `main` and `dev`.
    ```yaml
    cd exercise_lfs/arctic_animals.git
    git log --all --decorate --oneline --graph
    ```

   Are there any files that are not currently tracked by Git in the working
   tree?  
   We answer this question using **`git status`**, and find that our working
   tree is clean (and there is no `.gitignore` file either, so no files are
   ignored).

   What are the respective sizes of the `.git` and `.git/objects` repositories?
    ```yaml
    du -sh .git/
    #    61M  .git/
    du -sh .git/objects/
    #    61M  .git/objects/
    ```

2. Migrate all `.tif` and `.jpg` files to Git LFS throughout the entire history
   of the Git repo.
    ```yaml
    # We print the current history of the repo, so we can later compare it
    # to the history after the migration.
    git log --all --decorate --oneline --graph

    # Migrate all `.tif` and `.jpg` files to Git LFS.
    git lfs migrate import --include="*.tif,*.jpg" --everything

    # Compare the history with what we had before the "git lfs migrate" command.
    git log --all --decorate --oneline --graph
    ```

3. After the migration command, we can no longer open any of the images in the
   working tree. The reason for this is because the file content has been
   replaced by the content of the pointer, e.g. `mammals/animal_walrus.tif` now
   contains:
    ```
    version https://git-lfs.github.com/spec/v1
    oid sha256:3e45f949e2234094fd2946875a7e8b3a0ff9b182f85f0e4538471e59a00b5c81
    size 7994968
    ```

   To restore the files in the working tree, we run:
    ```yaml
    git lfs checkout
    ```
   Now the walrus image is back!

   To list all files that are tracked by Git LFS, we use:
   `git lfs ls-files --all`.  
   The files with a `*` are those that are currently checked-out.
    ```
    git lfs ls-files --all
    ea67d4f8a5 * birds/animal_atlantic_puffin.tif
    8c92a37ac7 * birds/animal_snowy_owl.jpg
    6b58d6ac09 - fish/animal_pink_salmon.tif
    1aa9297470 * mammals/animal_arctic_fox.jpg
    2519e9a194 - mammals/animal_blue_whale.tif
    47f090bd68 - mammals/animal_muskox.jpg
    3e45f949e2 * mammals/animal_walrus.tif
    4cf1383168 - birds/animal_emperor_penguin.tif
    642c1360fe - birds/animal_gentoo_penguin.jpg
    ```

   Finally, let's have a look at the size of the `.git/objects`, `.git/lfs` and
   `.git/` directories again.
   As can be seen below, the size of the `.git` directory has actually
   increased (doubled!), because we now have a copy of all files both in the
   Git LFS object store [`.git/lfs/objects`] and in the Git database
   [`.git/objects`].

    ```yaml
    du -sh .git
    #    133M  .git
    du -sh .git/objects
    #    61M  .git/objects
    du -sh .git/lfs
    #    73M  .git/lfs
    ```

   However, this is only temporary. At some point Git will do garbage
   collection of all the commits from the old history, and the copy of the
   files present in `.git/objects` will be removed.  
   To force immediate removal of the files, you can run:
    ```yaml
    git reflog expire --expire-unreachable=now --all
    git gc --prune=now
    ```

   The garbage collection has now reduced the size of the Git object store down
   to 40 KB !!
    ```yaml
    du -sh .git/objects/
    #    28K  .git/objects/
    ```

4. Adding the humpback whale image as a LFS-tracked file. Since the humpback
   whale is a mammal, we store it in the `mammals` sub-directory.
    ```yaml
    git switch dev
    cp ../animal_humpback_whale.bmp mammals/
    git lfs track "*.bmp"       # The ".bmp" is a new file type,
                                # we must tell Git LFS to track it.

    echo "Humpback Whale: Megaptera novaeangliae" >> mammals/mammal_list.txt
    git add mammals/animal_humpback_whale.bmp mammals/mammal_list.txt .gitattributes
    git commit -m "Add Humpback Whale"
    git switch main
    ```

5. Create a new empty repository on GitHub. The instructions for this are given
   in the exercise and it's all done via the GitHub website.

6. Now that we have an empty GitHub repo named `arctic_animals`, we can push
   the content of our local repo to it. First we add the URL of the remote,
   then we push our two branches.
   *Note:* the URL in the solution below depends on your GitHub username.
    ```yaml
    git remote add origin https://github.com/<GitHub user name>/arctic_animals.git
    git switch main
    git push -u origin main
    git switch dev
    git push -u origin dev
    ```

7. To clear the local Git LFS cache [`.git/lfs/objects`], we use the
   `git lfs prune` command. As can be seen below, there are 2 files that can
   be deleted, allowing us to reclaim 14 MB of disk space (83 - 69 = 14 MB).
   After clearing of the cache, the size of the local LFS cache is 69 MB.
    ```yaml
    git lfs prune --dry-run
    #    prune: 10 local object(s), 8 retained, done.
    #    prune: 2 file(s) would be pruned (8.4 MB), done.

    du -sh .git/lfs/       # Display the size of the local LFS cache.
    #    83M  .git/lfs/

    git lfs prune --verify-remote
    #    prune: 9 local object(s), 8 retained, 1 verified with remote, done.
    #    prune: Deleting objects: 100% (1/1), done.

    du -sh .git/lfs/       # Display the size of the local LFS cache.
    #    69M  .git/lfs/
    ```

8. Let's clone our `arctic_animals` repository at a different location, and see
   how much data is downloaded (this simulates another person cloning the
   repository).
    ```yaml
    cd ..
    git clone https://github.com/<GitHub user name>/arctic_animals.git arctic_animals_COPY
    cd arctic_animals_COPY

     # Display the size of the local Git object store and LFS cache.
    du -sh .git/objects
    #    32K  .git/objects
    du -sh .git/lfs
    #    32M  .git/lfs
    ```

   As can be seen above, the size of the Git object store [`.git/objects`] is
   now only 32 KB, and the size of the Git LFS cache [`.git/lfs`] is 32 MB.
   The Git LFS cache size is smaller than in the original repo (69 MB), because
   the `git clone` operation has only downloaded the files that are necessary
   for the latest commit of the `main` branch (the branch that is checked-out
   by default).  
   All other files will only be downloaded when they are necessary: e.g. the
   files needed for the `dev` branch will only be downloaded when doing a
   `git switch dev`.

9. On branch `main`, we edit the file `birds/birds_list.txt` and remove its 2
   last lines which contain the entries for the penguins. After this, we stage
   the modified `birds/birds_list.txt` file, and since the commit we wish to
   modify is the latest one on the current branch, we can simply use the
   `--amend --no-edit` options of `git commit`.
    ```yaml
    git switch main

    # Edit file birds/birds_list.txt: remove the last 2 lines.
    git add birds/birds_list.txt
    git commit --amend --no-edit
    ```

    Since this introduces a change in the history of branch `main`, we need to
    rebase `dev` on `main`. We can then push our changes on `dev` to the
    remote. Note that we must use the `--force` option of `git push` since we
    are re-writing history.
    ```yaml
    git switch dev
    git rebase main
    git push --force
    ```

    Finally we can do the same `--force` push on branch `main`, so that our
    local and remote repo are perfectly synchronized.
    ```yaml
    git switch main
    git push --force
    ```
