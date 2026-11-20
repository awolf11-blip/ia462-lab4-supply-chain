# Lab 4

## What this repo is
This repository contains a supply chain hardening lab for GitHub, Flask in Python, and Docker. To do this we pinned software versions, configured container scanning, and several other github securit features such as disabling committing directly to main. 

## Supply-chain controls enabled mapped to slides

- Pinning vs. Floating Dependencies
  - Used version hashes for the Docker image and GitHub Actions
  - Pinned python requirements to a specific version and compiled the file to lock it
- GitHub Dependency Security Tools
  - Dependabot checks if dependencies are outdated
  - Depencency graph is enabled
- Dependency Confusion & Supply Chain Attacks
  - Specific verison pinning
  - Secret scanning ensures we do not upload passwords
  - Push protection prevents writing directly to main
- Securing Dependencies in GitHub Actions
  - All actions used are pinned with the SHA hash
- Software Bill of Materials (SBOM)
  - Syft is install and generates the SBOM in the security pipeline
  - GitHub Dependecy graph also can output a SBOM JSON
- Integrating Dependency Scanning into CI/CD
  - The security pipeline builds the image inside of GitHub
  - Trivy is used to scan that built image
  - Syft generates the SBOM
  - Pip audit is used to check the dependencies
- GitHub's Dependency Review Action
  - When a PR is created it is scanned for outdated dependencies
  - If a PR has a high vulerability the PR is blocked

## How to reproduce vulnerable PR

1. Create a new branch
2. Edit requirements.txt to a known vulnerable version of flask and werkzeug
3. Recompile requirements.lock
4. Commit the files to the new branch
5. Create a pull request
6. Wait for the Pipeline to scan the new files
7. Merge is blocked due to vulerability
8. Close the pull request
9. Switch back to main branch
10. Pull code to sync with main
