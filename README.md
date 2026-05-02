
# GitOps-Based Cloud Application Deployment

A production-grade DevOps project developed as part of the **Chandigarh University — CU Online** program (School of Distance & Online Education, AY 2025–26).

---

## 📌 Project Overview

This project implements a complete end-to-end DevOps automation system for deploying a Java web application to the cloud using modern GitOps practices. Git serves as the single source of truth, with ArgoCD continuously reconciling the live cluster state to the declared desired state.

---

## 🏗️ Architecture

```
Developer → GitHub → Jenkins/GitHub Actions → Docker Build → AWS ECR
                                                                  ↓
ArgoCD (GitOps) ← Helm Manifest Repo ← Image Tag Update
      ↓
Amazon EKS (Kubernetes) → Prometheus + Grafana (Monitoring)
```

---

## 🛠️ Technology Stack

| Category | Tools |
|---|---|
| Application | Java 21, Apache Maven, Apache Tomcat 9 |
| Containerization | Docker (multi-stage build) |
| Orchestration | Kubernetes, Amazon EKS, Helm 3 |
| Infrastructure as Code | Terraform (7+ modules), Ansible |
| CI/CD / GitOps | Jenkins, GitHub Actions, ArgoCD |
| Monitoring | Prometheus, Grafana, Alertmanager |
| Cloud | AWS (EKS, ECR, VPC, RDS, Route53, IAM) |

---

## 📋 Project Milestones

| # | Milestone | Status |
|---|---|---|
| 01 | Develop Sample Application | ✅ Complete |
| 02 | Containerize with Docker | ✅ Complete |
| 03 | Deploy on Kubernetes (EKS) | 🔄 In Progress |
| 04 | Ansible Playbooks — Server Setup | 🔄 In Progress |
| 05 | Automate Cluster Configuration | ⏳ Pending |
| 06 | Integrate ArgoCD CI/CD Pipeline | ⏳ Pending |
| 07 | System Monitoring Setup | ⏳ Pending |
| 08 | Validate Automation Workflows | ⏳ Pending |
| 09 | Conduct Performance Tests | ⏳ Pending |
| 10 | Document Automation Scripts | ⏳ Pending |

---

## 🚀 Running Locally with Docker

**Prerequisites:** Docker installed and running.

```bash
# Clone the repository
git clone https://github.com/bheesham-devops/cuonline-sampleproject.git
cd cuonline-sampleproject

# Build the Docker image
docker build -t gitops-project:latest .

# Run the container
docker run -d --name gitops-project -p 8080:8080 gitops-project:latest
```

Open your browser at **http://localhost:8080/webapp/**

---

## 📁 Project Structure

```
sample-project/
├── Dockerfile              # Multi-stage Docker build
├── pom.xml                 # Root Maven POM
├── server/                 # Backend server module
│   └── src/
└── webapp/                 # Web application module
    └── src/main/webapp/
        └── index.jsp       # Main UI (GitOps dashboard)
```

---

## 👤 Author

**Bheesham Kumar**  
Chandigarh University — CU Online  
bheeshamkumar@gmail.com

---

## 📄 License

This project is submitted as part of an academic programme at Chandigarh University. All rights reserved.

