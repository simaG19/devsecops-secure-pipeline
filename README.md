# Secure DevSecOps CI/CD Pipeline

This repository implements a containerized Python Flask application integrated with an automated, security-first CI/CD pipeline using GitHub Actions. The pipeline acts as a security gauntlet, enforcing strict compliance checks, credential scanning, and vulnerability assessments before compilation.

## Pipeline Architecture & Security Gates

1. **Secret Scanning (TruffleHog)**
   * Scans the complete Git commit history to detect accidentally exposed high-entropy strings, API keys, and hardcoded cloud credentials.
   * Halts the pipeline immediately if any secrets are discovered.

2. **Dockerfile Linting (Hadolint)**
   * Validates the `Dockerfile` against OCI (Open Container Initiative) best practices.
   * Catches configuration defects such as untagged base images, un-nested package upgrades, or running processes as root.

3. **Vulnerability Scanning (Trivy)**
   * Compiles the local container image layers and scans the filesystem against up-to-date global CVE databases.
   * Set to fail the build if any `HIGH` or `CRITICAL` severity vulnerabilities are detected.

4. **Container Build Verification**
   * Executes a test build using Docker Buildx to guarantee image compile compliance across standard environments.

## Project Structure

```text
devsecops-secure-pipeline/
├── .github/
│   └── workflows/
│       └── secure-cicd.yml       # GitHub Actions workflow engine
├── app/
│   ├── app.py                    # Flask application entry point
│   └── requirements.txt          # Python application dependencies
├── Dockerfile                    # Hardened, non-root container blueprint
├── .gitignore                    # Standard Git exclusions
└── README.md                     # Technical documentation