# Exercise solutions - Optional Git modules - Git LFS

<br>

## Exercise 1 - Create a new Git repository from scratch with Git LFS file tracking

1. Initialize a new Git repository and make a first commit that adds the
   `README.md` file:

    ```sh
    cd exercise_lfs/test_lfs.git
    git init
    git add README.md
    git commit -m "First commit"
    ```

2. We start by telling Git LFS which files should be tracked. Then we add/stage
   all files and commit:

    ```sh
    # Tell Git LFS which files it should track.
    git lfs track logo.png "*.fasta" "db/db_file.txt"

    # Stage all files and commit.
    git add --all
    git commit -m "Add all files to the Git repo"
    ```

   Based on the pattern we gave to the `git lfs track` command, Git will
   store the files either as regular files or as LFS files.

3. Verify that the correct files are being tracked.

    ```sh
    git lfs ls-files
    #  0076e40fd3 * db/db_file.txt
    #  34804bc7cb * logo.png
    #  7db8ae7435 * sequences/sample_A.fasta
    #  bda5d8e934 * sequences/sample_B.fasta
    ```

   **🌈 Note:** to display the actual files in the LFS object store, we can use
   `ls -l .git/lfs/objects/*/*` or `tree .git/lfs/objects/`

4. **❓ Question answer:** since only a pointer/placeholder of the files tracked
   by Git LFS is stored in the Git database (the actual files are in the Git
   LFS cache), the `git show` command only shows the content of the pointer
   file, and not the content of the actual file.

5. **❓ Question answer:** for files tracked by Git LFS, `git diff` only shows
   the difference between the two versions of the pointer file, not the two
   versions of the file. Therefore it only displays the difference in hash
   value and in size between the two versions of a file.

<br>
<br>
<br>

## Exercise 2 - Migrate an existing directory to Git LFS [40 min]

1. Explore the `arctic_animals.git` repository. We can see that there are 2
   branches, `main` and `dev`.

    ```sh
    cd exercise_lfs/arctic_animals.git
    git log --all --decorate --oneline --graph
    ```

   Are there any files that are not currently tracked by Git in the working
   tree?

   We answer this question using **`git status`**, and find that our working
   tree is clean (and there is no `.gitignore` file either, so no files are
   ignored).

   What are the respective sizes of the `.git` and `.git/objects` directories?

    ```sh
    du -sh .git/          # -> 24M
    du -sh .git/objects/  # -> 24M
    ```

2. Migrate all `.tif` and `.jpg` files to Git LFS throughout the entire history
   of the Git repo.

    ```sh
    # We print the current history of the repo, so we can later compare it
    # to the history after the migration.
    git log --all --decorate --oneline --graph

    # Migrate all ".tif" and ".jpg" files to Git LFS.
    git lfs migrate import --include="*.tif,*.jpg" --everything

    # Compare the history with what we had before the "git lfs migrate" command.
    git log --all --decorate --oneline --graph
    ```

3. After the migration command, we can no longer open any of the images in the
   working tree. The reason for this is because the file content has been
   replaced by the content of the pointer, e.g. `mammals/animal_walrus.tif` now
   contains:

    ```txt
    version https://git-lfs.github.com/spec/v1
    oid sha256:50303f139c94a6eaa0537b4f06b2b68c1240de7b2d088917058192a7a439ee82
    size 4356928
    ```

   To restore the files in the working tree, we run:

    ```sh
    git lfs checkout
    ```

   Now the walrus image is back!

   To list all files that are tracked by Git LFS, we use:
   `git lfs ls-files --all`.

   The files with a `*` are those that are currently checked-out.

    ```sh
    git lfs ls-files --all
    #  0e7aca8749 * birds/animal_atlantic_puffin.tif
    #  488f476526 * birds/animal_snowy_owl.jpg
    #  024051c09d * fish/animal_pink_salmon.tif
    #  510d5b477b * logo.jpg
    #  bc487358a7 * mammals/animal_arctic_fox.jpg
    #  456948bde4 * mammals/animal_blue_whale.tif
    #  33ae6e09cb * mammals/animal_muskox.jpg
    #  50303f139c * mammals/animal_walrus.tif
    #  2392081802 - birds/animal_emperor_penguin.tif
    #  770c018a15 - birds/animal_gentoo_penguin.jpg
    ```

   Finally, let's have a look at the size of the `.git/objects`, `.git/lfs` and
   `.git/` directories again.
   As can be seen below, the size of the `.git` directory has actually
   increased (more than doubled!), because we now have a copy of all files both
   in the Git LFS object store [`.git/lfs/objects`] and in the Git database
   [`.git/objects`].

    ```sh
    du -sh .git
    #    52M  .git
    du -sh .git/objects
    #    24M  .git/objects
    du -sh .git/lfs
    #    29M  .git/lfs
    ```

   However, this is only temporary. At some point Git will do garbage
   collection of all the commits from the old history, and the copy of the
   files present in `.git/objects` will be removed.

   To force immediate removal of the files, you can run:

    ```sh
    git reflog expire --expire-unreachable=now --all
    git gc --prune=now
    ```

   The garbage collection has now reduced the size of the Git object store down
   to about 32 KB !!

    ```sh
    du -sh .git/objects/
    #    32K  .git/objects/
    ```

4. Adding the humpback whale image as an LFS-tracked file. Since the humpback
   whale is a mammal, we store it in the `mammals` sub-directory.

    ```sh
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

   **🌈 Note:** the URL in the solution below depends on your GitHub username.

    ```sh
    git remote add origin https://github.com/<GitHub user name>/arctic_animals.git
    git switch main
    git push -u origin main
    git switch dev
    git push -u origin dev
    ```

7. To clear the local Git LFS cache [`.git/lfs/objects`], we use the
   `git lfs prune` command. As can be seen below, there are 2 files that can
   be deleted (the two penguin images, which are no longer part of any
   branch), allowing us to reclaim about 3 MB of disk space (34 - 31 = 3 MB).
   After clearing of the cache, the size of the local LFS cache is 31 MB.

    ```sh
    git lfs prune --dry-run
    #    prune: 11 local objects, 9 retained, done.
    #    prune: 2 files would be pruned (3.3 MB), done.

    du -sh .git/lfs/       # Display the size of the local LFS cache.
    #    34M  .git/lfs/

    git lfs prune --verify-remote
    #    prune: 11 local objects, 9 retained, 2 verified with remote, done.
    #    prune: Deleting objects: 100% (2/2), done.

    du -sh .git/lfs/       # Display the size of the local LFS cache.
    #    31M  .git/lfs/
    ```

8. Let's clone our `arctic_animals` repository at a different location, and see
   how much data is downloaded (this simulates another person cloning the
   repository).

    ```sh
    cd ..
    git clone https://github.com/<GitHub user name>/arctic_animals.git arctic_animals_COPY
    cd arctic_animals_COPY

    # Display the size of the local Git object store and LFS cache.
    du -sh .git/objects
    #    28K  .git/objects
    du -sh .git/lfs
    #    14M  .git/lfs
    ```

   As can be seen above, the size of the Git object store [`.git/objects`] is
   now only 28 KB, and the size of the Git LFS cache [`.git/lfs`] is 14 MB.
   The Git LFS cache size is smaller than in the original repo (31 MB), because
   the `git clone` operation has only downloaded the files that are necessary
   for the latest commit of the `main` branch (the branch that is checked-out
   by default).  
   All other files will only be downloaded when they are necessary: e.g. the
   files needed for the `dev` branch will only be downloaded when doing a
   `git switch dev`.

9. On branch `main`, we edit the file `birds/bird_list.txt` and remove its 2
   last lines which contain the entries for the penguins. After this, we stage
   the modified `birds/bird_list.txt` file, and since the commit we wish to
   modify is the latest one on the current branch, we can simply use the
   `--amend --no-edit` options of `git commit`.

    ```sh
    git switch main

    # Edit file birds/bird_list.txt: remove the last 2 lines.
    git add birds/bird_list.txt
    git commit --amend --no-edit
    ```

    Since this introduces a change in the history of branch `main`, we need to
    rebase `dev` on `main`. We can then push our changes on `dev` to the
    remote. Note that we must use the `--force-with-lease` (or `--force`)
    option of `git push` since we are re-writing history.

    ```sh
    git switch dev
    git rebase main
    git push --force-with-lease
    ```

    Finally we can do the same `--force-with-lease` push on branch `main`, so
    that our local and remote repos are perfectly synchronized.

    ```sh
    git switch main
    git push --force-with-lease
    ```
