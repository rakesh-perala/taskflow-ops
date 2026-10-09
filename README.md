# taskflow-ops
"GitOps + IaC for TaskFlow — Terraform, ArgoCD, Helm, Prometheus. Enterprise AWS DevOps."


# ⚙️ TaskFlow Ops — Enterprise AWS DevOps Platform

> **GitOps + Infrastructure-as-Code for TaskFlow. Terraform, Helm, ArgoCD, Prometheus, Istio.**
> Multi-environment AWS platform built for enterprise-grade reliability and security.

![Terraform](https://img.shields.io/badge/Terraform-1.7+-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20RDS%20%7C%20S3-FF9900?logo=amazonaws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.29-326CE5?logo=kubernetes&logoColor=white)
![ArgoCD](https://img.shields.io/badge/GitOps-ArgoCD-EF7B4D?logo=argo&logoColor=white)
![Helm](https://img.shields.io/badge/Helm-3-0F1689?logo=helm&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📖 Table of Contents

1. [What is taskflow-ops](#1-what-is-taskflow-ops)
2. [Business Story](#2-business-story)
3. [Architecture Overview](#3-architecture-overview)
4. [Repository Structure](#4-repository-structure)
5. [Every File — What / Why / Where](#5-every-file--what--why--where)
6. [Environments](#6-environments)
7. [Local Setup (WSL Ubuntu)](#7-local-setup-wsl-ubuntu)
8. [Terraform — AWS Infrastructure](#8-terraform--aws-infrastructure)
9. [Helm — Application Deployment](#9-helm--application-deployment)
10. [ArgoCD — GitOps Deployment](#10-argocd--gitops-deployment)
11. [Observability Stack](#11-observability-stack)
12. [Security & Compliance](#12-security--compliance)
13. [Cost Management](#13-cost-management)
14. [Disaster Recovery](#14-disaster-recovery)
15. [CI/CD Integration](#15-cicd-integration)
16. [Real-Time Example — Full Deploy Flow](#16-real-time-example--full-deploy-flow)
17. [Troubleshooting Guide](#17-troubleshooting-guide)
18. [Root Cause Analysis](#18-root-cause-analysis)
19. [Interview Questions & Answers](#19-interview-questions--answers)
20. [How to Explain in Interview](#20-how-to-explain-in-interview)
21. [Related Repository](#21-related-repository)
22. [Best Practices & Lessons](#22-best-practices--lessons)

---

## 1. What is taskflow-ops

**taskflow-ops** is the **operations repository** for TaskFlow — it owns:
- Infrastructure as Code (Terraform)
- Helm charts for deployment
- ArgoCD Application manifests (GitOps)
- Observability stack (Prometheus, Grafana, Loki)
- Security policies (OPA, Kyverno)
- Runbooks for on-call engineers

**Separation from `taskflow-app`:** Devs ship code, ops ships infra. ArgoCD watches **only this repo**.

---

## 2. Business Story

### The Problem

The TaskFlow team was deploying manually:
- Engineers ran `kubectl apply` from laptops → drift + outages
- No environment parity between dev and prod
- Incidents took hours to debug (no logs/metrics/traces)
- Every new environment setup took 2 days

### The Ask

> "Build a **GitOps-driven**, **fully reproducible** platform where a `git push` = production change, with full observability and security from day one."

### The Solution

- **Terraform** provisions all AWS infra
- **ArgoCD** syncs K8s state from Git
- **Helm** packages the app for multi-env
- **Prometheus + Grafana + Loki** provide observability
- **OPA** enforces security policies in CI

### Success Metrics

| Metric | Before | After |
|--------|--------|-------|
| Env provisioning | 2 days | 30 min |
| Deploy frequency | 1/week | 20+/day |
| MTTR | 4 hours | 15 min |
| Drift incidents | Weekly | Zero |
| Audit compliance | Manual | Automated |

---

## 3. Architecture Overview

```mermaid
flowchart TB
    subgraph GH["🐙 GitHub"]
        APP["taskflow-app<br/>(code)"]
        OPS["taskflow-ops<br/>(this repo)"]
    end

    subgraph CI["🔧 CI"]
        GHA["GitHub Actions"]
        ECR["🐳 ECR"]
    end

    subgraph GITOPS["🚀 GitOps"]
        ARGO["ArgoCD"]
    end

    subgraph AWS["☁️ AWS"]
        subgraph NET["🌐 Network"]
            VPC
