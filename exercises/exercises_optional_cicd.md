# Optional module exercises: GitHub Actions and GitLab CI/CD

<br>

**Table of content**

[[_TOC_]]

<br>
<br>

## Exercises 1A and 1B - Introduction to automation pipelines [45 min]

:fire:
**Please read before starting:**  
In this exercise, we aim to build a pipeline that checks the quality of Python
code. Since building automation pipelines **differs between GitHub and GitLab**,
this exercise comes in 2 flavors:
* **Exercise 1A** is implementing the pipeline for a **GitHub** repository.
* **Exercise 1B** does the same, but for a **GitLab** hosted repository.

Select either exercise **5A (GitHub)** or **5B (GitLab)**, depending on the
platform that interests you most.

<br>
<br>
<br>

## Exercise 1A - Introduction to automation pipelines: GitHub Actions
**Objective:** learn the basics of creating automation pipelines for **GitHub**.

### A) Create a repository on GitHub

1. **Change into the `exercise_cicd` directory.** You will see that it
   already contains a Git repository with a couple of commits.

2. **Go to your GitHub account** and create a new repository. You will work on
   it alone, so you can make it private. **Do not initialize** the repository
   on GitHub, because we already have a local Git repo that we want to push.

3. **Add the GitHub remote to your local repo**, and push the content of your
   local repo to the remote.  
   Here is a reminder of how to do that:
    ```sh
    git remote add origin <URL of your remote>
    git push -u origin main
    ```

<br>

### B) Your first GitHub workflow
So far so good - but let's admit it: we stayed in our comfort zone!
This will all change now, as we create our first **GitHub Actions workflow**.  
This first workflow will be very simple and not do anything useful. It's just
a test to see if we can get a workflow to be picked-up by GitHub and run.

1. At the root of the local repository,
   **create a hidden directory named `.github`**.
2. Inside the `.github` directory, **create a `workflows` directory**.
3. Inside the workflows directory, **create a file named `test-workflow.yml`**
   and add the following content to it:
    ```yaml
    name: test-workflow
    run-name: Test workflow
    on: push

    jobs:
      # Comments can be added to the file like this.
      print-hello-world:
        runs-on: ubuntu-latest
        steps:
        - name: Say hello...
          run: echo “Hello World!”
    ```

   This is a very simple job - it basically does nothing outside of printing
   `Hello World!` to the terminal. It should in principle never fail.

4. **Commit the `test-workflow.yml` file** and **push** to the remote.
5. **Go to the Actions tab** of your repo on GitHub. You should see that a
   workflow was added, is running (or already finished to run), and succeeds.
6. **Click on the workflow**, and then on the `test-workflow` job to display the
   details of the job. You should see that that the job has printed
   `Hello World!` to the terminal.  

Well done - congrats on running your first GitLab CI/CD pipeline :tada: !

<br>

### C) Create a Python code check workflow
Now that we know how to run a workflow, let's up our game a little and create
an actually useful workflow.

As you might have noticed, our repository contains
[Python](https://www.python.org) code, so let's create a workflow that performs
the following 2 tasks:

* **format-check (job 1):** check the format of our python code, to make sure
  it follows the "best practice" guidelines.
* **syntax-check (job 2):** check the syntax of the python code, to make sure
  we have no error.

Let's do this one step at a time and add only the first job for now:
1. **Create a new workflow file** named `python-code-check.yml`.
   * The **`name`** of the workflow should be `python-code-check`.
   * The **`run-name`** of the workflow should be `Python code check`.
   * The workflow should **run on every push** to the repository.
   * :dart: **Hint:** make sure to create the file at the **correct location**.

2. **Add a first job** named **`format-check`** to the workflow. Here is the
   code for this job:
    ```yaml
    # Run the Python Black formatter.
    format-check:
      runs-on: ubuntu-latest
      steps:
      - name: Checkout git repo
        uses: actions/checkout@v4
      - name: Install Python
        uses: actions/setup-python@v4
      - name: Install black
        run: |
          python -m pip install --upgrade pip
          pip install black
      - name: Run black
        run: black --check .
    ```

    As you can see, this job has 4 steps:
    * It starts by making a checkout of our repository to the VM (virtual
      machine) that runs the job.
    * Then it installs Python on the VM (virtual machine).
    * Then it installs *[Black](https://github.com/psf/black)*, a Python
      format checker.
    * Finally it runs *Black* on all python files it can find in our repo.
      How *Black* works is not important for this exercise, just know that it
      looks at all Python code files it can find in the repository and will
      return an error if it detects that one or more files do not follow
      standard python formatting.

    :dart:
    **Hint:** make sure to indent all lines correctly when you write
    your GitHub workflow files.

3. **Commit** your new workflow **and push** to the remote.

4. Go to the **Actions tab** of your repo on GitHub and watch as your
   workflow is created :hatching_chick: ... runs :leopard: ...
   and hopelessly fails :broken_heart: !

5. What a bummer!! Yes, there is a format problem in the `simple_script.py`
   file... and we can identify it by **clicking on the workflow in GitHub**,
   and then clicking on the job to display its details.
   There you should see the error reported by the format checker.

6. The fix is easy though: open the `simple_script.py` file and change the
   line:
   ```py
   git_service=get_platform_name()
   ```

   To:
   ```py
   git_service = get_platform_name()
   ```

   This should fix the formatting issue that *Black* detected.

7. **Commit the change** to the file and push to the remote: the job should
   now succeeds.  
   That's it, life is back to being all rainbows and unicorns! :rainbow:

<br>
<br>
<details><summary><b>Solution part C)</b></summary>
<p>

You should have a file `.github/workflows/python-code-check.yml` that contains:

```yaml
name: python-code-check
run-name: Python code check
on: [push]

jobs:
  # Run the Python Black formatter.
  format-check:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout git repo
      uses: actions/checkout@v4
    - name: Install Python
      uses: actions/setup-python@v4
    - name: Install black
      run: |
        python -m pip install --upgrade pip
        pip install black
    - name: Run black
      run: black --check .
```

</p>
</details>
<br>

### D) Add a second job to the Python code check workflow
Now that we got the first job working, let's add a second job to our workflow.
This second job should run a Python code syntax checker called
*[Pylint](https://github.com/pylint-dev/pylint)*.

The job should be named **syntax-check**, and, just like our first job in the
workflow, this job should have 4 steps:
* **Step 1:** checkout the repository to the VM.
* **Step 2:** Install Python.
* **Step 3:** Install *Pylint*. The shell commands to install *Pylint* are the
  following:
  ```sh
  python -m pip install --upgrade pip
  pip install pylint
  ```
* **Step 4:** Run *Pylint* using the following command:
  ```sh
  pylint $(git ls-files '*.py')
  ```

<br>

**Add this second job to the `python-code-check.yml` workflow**, then commit your
changes and push to the remote.  
The Python code in the repo does not contain any syntax error, so the new
job **should succeed**.

<br>
<br>
<details><summary><b>Solution part D)</b></summary>
<p>

The file `.github/workflows/python-code-check.yml` should now look like:

```yaml
name: python-code-check
run-name: Python code check
on: [push]

jobs:
  # Run the Python Black formatter.
  format-check:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout git repo
      uses: actions/checkout@v4
    - name: Install Python
      uses: actions/setup-python@v4
    - name: Install black
      run: |
        python -m pip install --upgrade pip
        pip install black
    - name: Run black
      run: black --check .

  # Run pylint, a Python code linter (checks for syntax errors).
  syntax-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
    - name: Install pylint
      run: |
        python -m pip install --upgrade pip
        pip install pylint
    - name: Run pylint
      run: |
        pylint $(git ls-files '*.py')
```

</p>
</details>
<br>


### E) Add a job that depend on jobs 1 and 2
Let's continue improving our `python-code-check.yml` workflow by adding
another job to it:
* **unit-tests (job 3):** runs
  [unit-tests](https://en.wikipedia.org/wiki/Unit_testing) on our code.

Unlike the first 2 jobs of the workflow, **jobs 3 should run conditionally**:
job 3 should only run if both jobs 1 (**format-check**) *and*
job 2 (**syntax-check**) completed successfully.  
Here are the instructions for job 3
```yaml
# Run unit-tests for our code.
unit-tests:
  needs: [format-check, syntax-check]
  runs-on: ubuntu-latest
  steps:
  - uses: actions/checkout@v4
  - uses: actions/setup-python@v4
    with:
      python-version: '3.11'
  - name: Install pytest
    run: |
      python -m pip install --upgrade pip
      pip install pytest
  - name: Run pytest
    run: |
      pytest test_*.py
```

* The **`needs: `** keyword is used to indicate that the job depends on other
  jobs. In this case, `needs: [format-check, syntax-check]` means that this
  job will depend on both jobs 1 (**format-check**) *and* job 2
  (**syntax-check**). In other words, job 3 will only run if both job 1 and 2
  complete.
* For this job, we require a **specific Python version: `3.11`**. This is done
  by adding the instructions `with:` and `python-version: '3.11'` to the
  step `actions/setup-python@v4`.

<br>

**Add the job 3** to the `python-code-check.yml` workflow, and verify that
all jobs in the workflow run as expected (go to the GitHub **Action tab** to
check this). This job should succeed.

**To test that the conditional execution** really works, let's try to make
Job 2 fail by introducing an error into the file `simple_script.py`:
1. **Open the file** `simple_script.py` with a text editor.
2. **Change line 4** of the script from `import os` to `# import os` (this
   changes the code line to a comment). This will create a error detected by
   *Pylint*.
3. **Commit the change** to `simple_script.py` and push it to the remote.
4. You should now see that **job 2 fails** and therefore
   **job 3 should no longer be run**.

<br>

### F) Add a fourth - and final - job to `python-code-check.yml`
Almost done: let's add a final job to our `python-code-check.yml` workflow:
* **test-run-script (job 4):** runs the entire `simply_script.py` script, to
  verify that it runs without error (this is sometimes referred to as an
  "integration test").

You task is to add this new job to the workflow, so that:
* The job is named **test-run-script**.
* The job should only run if job 3 completes successfully.
* The job should install python version `3.11`.
* As its last step, the job should run the command:
  `GIT_HOST_SERVICE="GitHub" ./simple_script.py`

When you are done, commit your changes to the workflow and push them to the
remote.

To verify that your Job 4 is running properly:
* **Go to the GitHub Actions tab.**
* **Click on the latest run** of the "Python code check" workflow, then make sure
  that all 4 jobs completed.
* **Click on job test-run-script** (job 4), and in the details of the step
  that runs the script, you should see the text `Greetings, fellow GitHub user.`
  displayed. This indicates that `simple_script.py` has completed successfully.

<br>
<br>
<details><summary><b>Solution part F)</b></summary>
<p>

The instructions for the **test-run-script** job should look like:

```yaml
# Test run the entire script (integration test).
test-run-script:
  runs-on: ubuntu-latest
  needs: unit-tests
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    - name: Run script
      run: GIT_HOST_SERVICE="GitHub" ./simple_script.py
```

</p>
</details>

<details><summary><b>Overall solution to exercise 1A</b></summary>
<p>

You can find the final workflow in the file `.solutions/python-code-check.yml`
of this exercise's directory.

</p>
</details>


<br>
<br>
<br>


## Exercise 1B - Introduction to automation pipelines: GitLab CI/CD
**Objective:** learn the basics of creating automation pipelines for **GitLab**.

### A) Create a repository on GitLab

1. **Change into the `exercise_cicd` directory.** You will see that it
   already contains a Git repository with a couple of commits.

2. **Go to your GitLab account** and create a new repository. You will work on
   it alone, so you can make it private. **Do not initialize** the repository
   on GitLab, because we already have a local Git repo that we want to push.

3. **Add the GitLab remote to your local repo**, and push the content of your
   local repo to the remote.  
   Here is a reminder of how to do that:
    ```sh
    git remote add origin https://gitlab.com/<URL of your remote>
    git push -u origin main
    ```

<br>

### B) Your first GitLab CI/CD pipeline
So far so good - but let's admit it: we stayed in our comfort zone!
This will all change now, as we create our first **GitLab CI/CD pipeline**.  
This first pipeline will be very simple and not do anything useful. It's just
a test to see if we can get a pipeline to be picked-up by GitLab and run.

1. At the root of the local repository,
   **create a new file named `.gitlab-ci.yml`**.

2. **Copy-paste the following content** to the file:
    ```yaml
    # GitLab CI/CD configuration file.
    workflow:
      name: "Test workflow"

    stages:
        - test

    # For this test pipeline, we use a Linux "alpine" image because it is a
    # very lightweight image (Alpine Linux is a minimalist Linux distro).
    test-pipeline:
        stage: test
        image: alpine:latest
        script:
            - echo "Hello World!"
    ```

   This is a very simple job - it basically does nothing outside of printing
   `Hello World!` to the terminal. It should in principle never fail.

3. **Commit the `.gitlab-ci.yml` file** and **push** to the remote.

4. **Go to the "Build > Pipelines tab"** of your repo on GitLab. You should
   see that a pipeline was added, is running (or already finished to run),
   and succeeds.

5. **Click on the pipeline**, and then on the `test-pipeline` job to display
   the details of the job. You should see that that the job has printed
   `Hello World!` to the terminal.  

Well done - congrats on running your first GitLab CI/CD pipeline :tada: !

<br>

### C) Create a Python code check pipeline
Now that we know how to run a pipeline, let's up our game a little and create
an actually useful pipeline.

As you might have noticed, our repository contains
[Python](https://www.python.org) code, so let's create a pipeline that performs
the following 2 tasks:

* **format-check (job 1):** check the format of our python code, to make sure
  it follows the "best practice" guidelines.
* **syntax-check (job 2):** check the syntax of the python code, to make sure
  we have no error.

Let's do this one step at a time and add only the first job for now:
1. **Edit the `.gitlab-ci.yml` file**:
   * Remove the `test-pipeline` job.
   * Change the **name** of the workflow to `Python code check`.
   * Change the name of the **first stage** of the pipeline to `syntax-check`
     (note: at this point the pipeline has a single stage).
   * The pipeline should **run on every push** to the repository. This is
     the default behavior in GitLab CI/CD, so there is nothing special to do.

2. **Add a first job** named **`format-check`** to the pipeline.  
   Here is the code for this job:

    ```yaml
    # Run the Python Black formatter.
    format-check:
      stage: syntax-check
      image: python:slim
      before_script:
        # Install the Black python formatter.
        - python -m pip install --upgrade pip
        - pip install black
      script:
      # Run the Black Python code formatter.
        - black --check .
    ```

    Here are some notes about the job:
    * **`stage:`** indicates which **stage** the job belongs-to. The value
      must correspond to one of the stages listed under the **`stages:`**
      entry in the `.gitlab-ci.yml` file.
    * **`image:`** indicates the container to use for running our job.
      We here use `python:slim`, an
      [official DockerHub python image](https://hub.docker.com/_/python)
      that is built to be lightweight.
    * **`before_script:`** commands to be executed before the `script` stage.
      Here we install *[Black](https://github.com/psf/black)*, a Python
      format checker.
    * **`script:`** this final step of the job runs *Black* on all python
      files it can find in our repo.  
      How *Black* works is not important for this exercise, just know that it
      looks at all Python code files it can find in the repository and will
      return an error if it detects that one or more files do not follow
      standard python formatting.

    **Important:** make sure to indent all lines correctly when you write
    your GitLab CI/CD files.

3. **Commit your changes** to the `.gitlab-ci.yml` file **and push** to the
   remote.

4. Go to **Build > Pipelines tab** of your repo on GitLab and watch as your
   pipeline is created :hatching_chick: ... runs :leopard: ...
   and hopelessly fails :broken_heart: !

5. What a bummer!! Yes, there is a format problem in the `simple_script.py`
   file... and we can identify it by **clicking on the pipeline in GitLab**,
   and then clicking on the job to display its details.
   There you should see the error reported by the format checker.

6. The fix is easy though: open the `simple_script.py` file and change the
    line:
    ```py
    git_service=get_platform_name()
    ```

    To:
    ```py
    git_service = get_platform_name()
    ```

  This should fix the formatting issue that *Black* detected.

7. **Commit the change** to the file and push to the remote: the job should
   now succeeds.  
   That's it, life is back to being all rainbows and unicorns! :rainbow:


<br>
<br>
<details><summary><b>Solution part C)</b></summary>
<p>

The file `.gitlab-ci.yml` should look like:

```yaml
# GitLab CI/CD configuration file.

workflow:
  name: "Python code check"

stages:
  - syntax-check

# Run the Python Black formatter.
format-check:
  stage: syntax-check
  image: python:slim
  before_script:
    # Install the Black Python formatter.
    - python -m pip install --upgrade pip
    - pip install black
  script:
    # Run the Black Python code formatter.
    - black --check .
```

</p>
</details>
<br>

### D) Add a second job to the Python code check pipeline
Now that we got the first job working, let's add a second job to our pipeline.
This second job should run a Python code syntax checker called
*[Pylint](https://github.com/pylint-dev/pylint)*.

The job should be named **syntax-check**, and, just like our first job in the
pipeline, this job should do the following:
* Be part of the same **stage** as the first job: `syntax-check`.
* **Use `python:slim`** as container to run the job.
* **Install _Pylint_**. The shell commands to install *Pylint* are the
  following:
  ```sh
  python -m pip install --upgrade pip
  pip install pylint
  ```
* **Run _Pylint_** using the following command:
  ```sh
  pylint $(ls *.py)
  ```

<br>

**Add this second job to the `Python code check` pipeline**, then commit your
changes and push to the remote.  
The Python code in the repo does not contain any syntax error, so the new
job **should succeed**.

<br>
<br>
<details><summary><b>Solution part D)</b></summary>
<p>

The file `.gitlab-ci.yml` should now look like:

```yaml
# GitLab CI/CD configuration file.

workflow:
  name: "Python code check"

stages:
  - syntax-check

# Run the Python Black formatter.
format-check:
  stage: syntax-check
  image: python:slim
  before_script:
    # Install the Black Python formatter.
    - python -m pip install --upgrade pip
    - pip install black
  script:
    # Run the Black Python code formatter.
    - black --check .

# Run pylint, a Python code linter (checks for syntax errors).
syntax-check:
  stage: syntax-check
  image: python:slim
  before_script:
    python -m pip install --upgrade pip
    pip install pylint
  script:
    # Run the Pylint syntax checker.
    pylint $(ls *.py)
```

</p>
</details>
<br>


### E) Add a job that depend on jobs 1 and 2
Let's continue improving our `Python code check` pipeline by adding another
job to it:
* **unit-tests (job 3):** will run the
  [unit-tests](https://en.wikipedia.org/wiki/Unit_testing) for the code.

Unlike the first 2 jobs of the pipeline, **jobs 3 should run conditionally**:
it should only run if both jobs 1 (**format-check**) *and* job 2
(**syntax-check**) completed successfully.

**There are 2 options to make a job conditional** on other jobs in GitLab CI/CD:
1. Add the job to a different **stage** of the pipeline (we will use this
   method in this exercise). Jobs in a given stage will only run if all jobs
   from the previous stage have completed successfully.
2. Add the **`needs: [<job to depend on>]`** keyword to the job. This can be
   used e.g. to create dependency rules within the same stage. We will not use
   this method here, but you can read about it in the GitLab documentation
   if interested.

<br>

Here are the instructions for job 3:
```yaml
# Run unit-tests for our code.
unit-tests:
  stage: unit-tests
  image: python:slim
  before_script:
    # Install Pytest.
    - python -m pip install --upgrade pip
    - pip install pytest
  script:
    # Run unit-tests with Pytest.
    - pytest test_*.py
```

<br>

**Add the job 3** to the `Python code check` pipeline, and verify that
all jobs in the pipeline run as expected (go to the GitLab **Pipelines tab**
to check this). This job should succeed.  
:dart:
**Hint:** don't forget to define `unit-tests` as a new stage of the pipeline!

**To test that the conditional execution** really works, let's try to make
Job 2 fail by introducing an error into the file `simple_script.py`:
1. **Open the file** `simple_script.py` with a text editor.
2. **Change line 4** of the script from `import os` to `# import os` (this
   changes the code line to a comment). This will create a error detected by
   *Pylint*.
3. **Commit the change** to `simple_script.py` and push it to the remote.
4. You should now see that **job 2 fails** and therefore
   **job 3 should no longer be run**.

<br>
<br>
<details><summary><b>Solution part E)</b></summary>
<p>

The `stages:` section of the pipeline should now look like this:

```yaml
stages:
  - syntax-check
  - unit-tests
```

</p>
</details>
<br>

### F) Add a fourth - and final - job to the `Python code check` pipeline
Almost done: let's add a final job to our `Python code check` pipeline:
* **test-run-script (job 4):** runs the entire `simply_script.py` script, to
  verify that it runs without error. This is sometimes referred to as an
  "integration test".

You task is to add this new job to the pipeline, so that:
* The job is named **test-run-script**.
* **It uses `python:slim`** as container to run the job.
* The job **only runs if all previous jobs complete successfully**. To
  achieve this, you should add the job to a different stage: the
  `integration-tests` stage.
* As its last step, the job should **run the command**:
  `GIT_HOST_SERVICE="GitLab" ./simple_script.py`
* :dart:
  **Hints:**
  * You should add a new stage named `integration-tests` to the list of stages
    of the pipeline.
  * To indicate that your job belongs to the `integration-tests` stage, use the
    `stage: integration-tests` key-value pair.
  * This job does not need a `before_script:` section, because there is nothing
    additional to install (Python is needed, but it comes already in the
    `python:slim` container).

When you are done, commit your changes to the pipeline and push them to the
remote.  
To verify that your pipeline is running properly:
* Go to the GitLab **Pipelines tab**.
* Click on the latest run of the `Python code check` pipeline, then make sure
  that all 4 jobs completed.
* Click on job **test-run-script** (job 4), and in the details of the step
  that runs the script, you should see the text `Greetings, fellow GitLab user.`
  displayed. This indicates that `simple_script.py` has completed successfully.


<br>
<br>
<details><summary><b>Solution part F)</b></summary>
<p>

The instructions for the **test-run-script** job should look like:

```yaml
# Test run the entire script (integration test).
test-run-script:
  stage: integration-tests
  image: python:slim
  script:
    # Run the script.
    - GIT_HOST_SERVICE="GitLab" ./simple_script.py
```

</p>
</details>

<details><summary><b>Overall solution to exercise 1B</b></summary>
<p>

You can find the final pipeline in the file `.solutions/.gitlab-ci.yml`
of this exercise's directory.

</p>
</details>
<br>

<br>
<br>
<br>
