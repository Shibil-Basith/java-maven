# 🚀 Java Maven CI/CD Pipeline

> **Automated Build · Test · Deploy** — From a `git push` to a live web app, completely hands-free.

[![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=flat-square&logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Maven](https://img.shields.io/badge/Maven-Build-C71A36?style=flat-square&logo=apache-maven&logoColor=white)](https://maven.apache.org/)
[![Java](https://img.shields.io/badge/Java-17-007396?style=flat-square&logo=openjdk&logoColor=white)](https://openjdk.org/)
[![Apache Tomcat](https://img.shields.io/badge/Tomcat-Deploy-F8DC75?style=flat-square&logo=apache-tomcat&logoColor=black)](https://tomcat.apache.org/)
[![GitHub Webhooks](https://img.shields.io/badge/GitHub-Webhooks-181717?style=flat-square&logo=github&logoColor=white)](https://docs.github.com/en/webhooks)
[![Platform](https://img.shields.io/badge/Platform-Linux-FCC624?style=flat-square&logo=linux&logoColor=black)](https://ubuntu.com/)

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Pipeline Flow](#-pipeline-flow)
- [Tools & Technologies](#-tools--technologies)
- [Project Structure](#-project-structure)
- [Environment Setup](#-environment-setup)
- [Jenkins Pipeline (Jenkinsfile)](#-jenkins-pipeline-jenkinsfile)
- [GitHub Webhook Configuration](#-github-webhook-configuration)
- [Deployment](#-deployment)
- [Challenges & Solutions](#-challenges--solutions)
- [Security Considerations](#-security-considerations)
- [Future Improvements](#-future-improvements)

---

## 🌟 Overview

This project demonstrates a **fully automated, end-to-end CI/CD pipeline** using industry-standard open-source tools. Every `git push` to the `main` branch automatically triggers the entire pipeline — no manual steps required.

**What happens automatically:**
1. GitHub detects a push and fires a webhook to Jenkins
2. Jenkins clones the repo and builds the Java app with Maven
3. The WAR artifact is transferred to a remote agent node
4. Apache Tomcat deploys the app and serves it live

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        CI/CD Pipeline                           │
│                                                                 │
│  Developer ──▶ GitHub ──(webhook)──▶ Jenkins Controller        │
│                                           │                     │
│                                    ┌──────▼──────┐              │
│                                    │  BUILD STAGE │             │
│                                    │  (built-in)  │             │
│                                    │  mvn clean   │             │
│                                    │  package     │             │
│                                    └──────┬───────┘             │
│                                           │ stash WAR           │
│                                    ┌──────▼───────┐             │
│                                    │ DEPLOY STAGE │             │
│                                    │  (slave)     │             │
│                                    │  unstash →   │             │
│                                    │  ROOT.war →  │             │
│                                    │  Tomcat      │             │
│                                    └──────┬───────┘             │
│                                           │                     │
│                                    http://<agent-ip>:8080/      │
└─────────────────────────────────────────────────────────────────┘
```

### Components

| Component | Role | Node |
|-----------|------|------|
| **Jenkins Controller** | Orchestrates pipeline, receives webhook, runs build | `built-in` |
| **Jenkins Agent (Slave)** | Receives artifact, deploys to Tomcat | `slave` |
| **GitHub Repository** | Stores source code, fires push webhooks | Remote |
| **Apache Tomcat** | Serves the deployed Java web application | Agent node |

---

## 🔄 Pipeline Flow

```
git push
   │
   ▼
GitHub Webhook ──POST──▶ Jenkins (port 8080)
                               │
                        Clone Repository
                               │
                        mvn clean package
                               │
                        stash target/*.war
                               │
                    ┌──────────▼──────────┐
                    │   Agent (slave)     │
                    │  unstash WAR        │
                    │  rename → ROOT.war  │
                    │  cp → webapps/      │
                    └──────────┬──────────┘
                               │
                    Tomcat auto-deploys
                               │
                    http://<agent-ip>:8080/ ✅
```

---

## 🛠️ Tools & Technologies

| Tool | Version | Purpose |
|------|---------|---------|
| **OpenJDK** | 21 | Java runtime for all pipeline components |
| **Maven** | 3.x | Build automation — compiles and packages the WAR |
| **Git** | Latest | Source code version control |
| **GitHub** | — | Remote repo + webhook event source |
| **Jenkins** | LTS | CI/CD engine — orchestrates the pipeline |
| **Apache Tomcat** | 10.1.x | Java servlet container — serves the web app |
| **Linux (Ubuntu)** | 22.04+ | Operating system for all nodes |

---

## 📁 Project Structure

```
java-maven/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/
│       │       └── App.java          # Main application class
│       └── webapp/
│           └── WEB-INF/
│               └── web.xml           # Servlet configuration
├── pom.xml                           # Maven project descriptor
└── Jenkinsfile                       # Pipeline as Code
```

---

## ⚙️ Environment Setup

### Jenkins Controller Node

```bash
# 1. Install OpenJDK 21
sudo apt update
sudo apt install openjdk-21-jdk -y

# 2. Install Maven
sudo apt install maven -y

# 3. Install Git
sudo apt install git -y

# 4. Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
  sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update && sudo apt install jenkins -y
sudo systemctl start jenkins && sudo systemctl enable jenkins

# 5. Get initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

> Jenkins UI available at: `http://<controller-ip>:8080`

---

### Tomcat Agent Node

```bash
# 1. Install OpenJDK 21
sudo apt update && sudo apt install openjdk-21-jdk -y

# 2. Create Tomcat user and install Tomcat
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.x/bin/apache-tomcat-10.1.x.tar.gz
sudo tar -xzf apache-tomcat-*.tar.gz -C /opt/tomcat --strip-components=1
sudo chown -R tomcat: /opt/tomcat
sudo chmod +x /opt/tomcat/bin/*.sh

# 3. Create Tomcat systemd service
sudo nano /etc/systemd/system/tomcat.service
```

<details>
<summary>📄 tomcat.service contents</summary>

```ini
[Unit]
Description=Apache Tomcat Web Application Server
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64"
Environment="CATALINA_HOME=/opt/tomcat"
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```
</details>

```bash
sudo systemctl daemon-reload
sudo systemctl start tomcat && sudo systemctl enable tomcat

# 4. Allow Jenkins to write to webapps/
sudo chmod 777 /opt/tomcat/webapps/
```

---

### Jenkins Master-Agent (SSH) Setup

```bash
# On Jenkins Controller — generate SSH key pair
sudo -u jenkins ssh-keygen -t rsa -b 4096 -C 'jenkins-agent'
# Private key: /var/lib/jenkins/.ssh/id_rsa
# Public key:  /var/lib/jenkins/.ssh/id_rsa.pub

# On Agent Machine — authorize the public key
mkdir -p ~/.ssh
echo '<paste-public-key-here>' >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```

**Register Agent in Jenkins UI:**
1. Go to **Manage Jenkins → Nodes → New Node**
2. Set **Label**: `slave`
3. **Remote root directory**: `/home/ubuntu/jenkins-agent`
4. **Launch method**: SSH → provide agent IP + SSH credentials
5. Save — agent will come online automatically

---

## 🧩 Jenkins Pipeline (Jenkinsfile)

```groovy
pipeline {
    agent none
    stages {

        stage("build") {
            agent {
                label 'built-in'
            }
            steps {
                git branch: 'main', url: 'https://github.com/Shibil-Basith/java-maven.git'
                sh "mvn clean package"
                stash name: 'build', includes: 'target/*.war'
            }
        }

        stage('deploy') {
            agent {
                label 'slave'
            }
            steps {
                unstash 'build'
                sh "rm -rf target/ROOT.war"
                sh "mv target/*.war target/ROOT.war"
                sh "cp target/ROOT.war /opt/tomcat/webapps/"
            }
        }

    }
}
```

### Stage Breakdown

| Stage | Agent | What it does |
|-------|-------|-------------|
| `build` | `built-in` (controller) | Clones repo → runs `mvn clean package` → stashes WAR |
| `deploy` | `slave` (agent) | Unstashes WAR → renames to `ROOT.war` → copies to Tomcat `webapps/` |

> **Why `stash/unstash` over SCP?** It's a native Jenkins feature — no extra SSH configuration, works across any network topology, and is fully handled through Jenkins' internal channels.

---

## 🔗 GitHub Webhook Configuration

1. Go to your repo → **Settings → Webhooks → Add webhook**
2. **Payload URL**: `http://<jenkins-controller-ip>:8080/github-webhook/`
3. **Content type**: `application/json`
4. **Event**: Just the push event
5. Click **Add webhook**

**In Jenkins Job:**
- Enable: `GitHub hook trigger for GITScm polling` under **Build Triggers**

> ⚠️ **403 Forbidden error?** Install the **GitHub Integration Plugin** in Jenkins. It handles webhook authentication correctly without CSRF conflicts.

---

## 🚢 Deployment

Once the pipeline completes, your app is live at:

```
http://<agent-node-ip>:8080/
```

The WAR is renamed to `ROOT.war` so Tomcat serves it at the root context path (`/`) — no sub-path needed.

**Verify deployment:**
```bash
# Check webapps directory — ROOT/ folder should exist
ls /opt/tomcat/webapps/

# Tail Tomcat logs
tail -f /opt/tomcat/logs/catalina.out
```

---

## 🐛 Challenges & Solutions

| Problem | Root Cause | Solution |
|---------|-----------|----------|
| `mvn: command not found` | Maven not on PATH | `sudo apt install maven -y` |
| GitHub 403 on `git clone` | Wrong URL or private repo | Use correct public URL or configure GitHub credentials in Jenkins |
| Webhook 403 Forbidden | Jenkins CSRF blocking GitHub POST | Install **GitHub Integration Plugin** |
| Multiple WAR file conflict | Old build artifacts causing ambiguous `mv` | Added `rm -rf target/ROOT.war` before `mv` |
| Tomcat not auto-deploying | Wrong permissions on `webapps/` | `chmod 777 /opt/tomcat/webapps/` |
| Agent offline in Jenkins | SSH key mismatch or port 22 blocked | Verified `authorized_keys`; ensured port 22 open on agent |

---

## 🔒 Security Considerations

- **SSH key auth only** — no password authentication on agents; private key stored encrypted in Jenkins credential store
- **Least privilege** — Jenkins agent user has access only to required directories
- **Webhook secrets** — configure a secret token in GitHub webhook settings and verify in Jenkins
- **HTTPS** — serve Jenkins behind an NGINX reverse proxy with a valid TLS certificate in production
- **RBAC** — enable Jenkins Role-Based Access Control to limit user permissions
- **Key rotation** — regularly rotate SSH keys and audit `authorized_keys` on agent machines

---

## 🔮 Future Improvements

| Enhancement | Benefit |
|-------------|---------|
| 🐳 **Docker Integration** | Package app as a container image; consistent environments, easy rollbacks |
| ☸️ **Kubernetes Deployment** | Auto-scaling, self-healing, zero-downtime rolling updates via Helm |
| 📦 **Nexus Artifact Repository** | Artifact versioning, audit trail, and reuse across environments |
| 🔍 **SonarQube Integration** | Static code analysis — catch code smells and security vulnerabilities |
| 🟦🟩 **Blue-Green Deployment** | Zero-downtime deployments with instant traffic switching |
| ✅ **Automated Testing Stage** | Unit + integration + smoke tests before every deploy |
| 🔔 **Slack/Email Notifications** | Instant build status alerts to keep the team informed |

---

## 👤 Author

**Shibil Basith**  
GitHub: [@Shibil-Basith](https://github.com/Shibil-Basith)  
Project: `java-maven` | Branch: `main` | Platform: Linux

---

> *"Automation is not about replacing humans — it's about freeing them to do more meaningful work."*
