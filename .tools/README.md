# Tools
To update the lessons available on the public-facing wptrainingteam.github.io, follow these steps.

## Omit Non-Lesson Repositories
Several repositories within the organization are not lesson plans. These should not be included on this site. To omit a repo from this site, add its clone URL to a new line in **omitted-repos.manifest.**

## About Git Submodules
When you clone this repository using `git clone https://github.com/wptrainingteam/wptrainingteam.github.io.git` your local copy will not initially include the lesson plan submodules. You will only have pointers to a specific commit of each lesson plan repository, until you either run the command `git submodule init` or run the update-lessons.sh script.

The submodules are set to track the head of the "Master" branch of each repository, but in order for them to track, they must be merged with the current remote origin.

## The update-lessons.sh Script
When updates have been made to lesson plans, or a new lesson plan repository has been added to the project, it is time to update this repository.

1. Fork this repository.
2. Clone your fork.
  ```
  $ git clone https://github.com/<yourusername>/wptrainingteam.github.io.git
  ```
3. Checkout the `dev` branch.
  ```
  $ git checkout -b dev
  ```
4. Change to the `.tools` directory.
  ```
  $ cd wptrainingteam.github.io/.tools
  ```
5. Run the script.
  ```
  $ ./update-lessons.sh
  ```
6. The script will:
  * Fetch a list of all repositories within the wptrainingteam organization.
  * Compare this list to **omitted-repos.manifest** and place all the others into **lesson-plans.manifest**
  * Attempt to add each lesson plan as a submodule within the `lesson-plan` directory.
    * If the lesson plan is not new, an message prints and the script moves on.
  * Initialize and synchronize all submodules.
  * Update and merge all submodules from the remote master.
  * Populate `lesson-plan/README.md` with links to each lesson plan and slides.
7. Stage all updates.
  ```
  $ git add --all
  ```
8. Commit your changes.
  ```
  $ git commit -m "Update to current lesson plans."
  ```
9. Push your changes.
  ```
  $ git push
  ```
10. Submit a pull request back to the wptrainingteam organization.
