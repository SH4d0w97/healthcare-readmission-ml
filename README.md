# 🏥 Healthcare Readmission Risk Prediction

**An End-to-End, Production-Style Data Science Project (Python + SQL)**

---

## 📌 Project Overview

Hospital readmissions within 30 days of discharge are a major challenge for healthcare systems. They increase costs, strain resources, and often indicate gaps in care quality.

This project builds a **complete, real-world data science pipeline** to predict **30-day hospital readmission risk**, using healthcare data and production-style engineering practices.

The repository is designed to serve **two purposes at once**:

1. 📘 **A step-by-step learning guide** for anyone starting in data science
2. 💼 **A professional portfolio project** demonstrating real industry skills

---

## 🎯 Problem Statement

> **Predict whether a patient will be readmitted to the hospital within 30 days after discharge.**

This is framed as a **binary classification problem**, with special attention to:

* Class imbalance
* Healthcare-appropriate evaluation metrics
* Model interpretability and trust

---

## 🧠 Why This Project Is Different

Most data science projects stop at *“train a model and show accuracy.”*
This one focuses on **how data science actually works in real teams**.

✔ SQL-first data analysis
✔ Reproducible pipelines
✔ Production-ready project structure
✔ Healthcare-specific reasoning
✔ Explainable ML (SHAP)
✔ Simple deployment for inference

---

## 🧪 Dataset

The project uses the **Diabetes 130-US Hospitals Dataset** from the
UCI Machine Learning Repository

**Key characteristics:**

* Real hospital encounter data
* Demographics, diagnoses, medications, lab results
* Readmission outcome variable
* Messy, imperfect data (just like real life)

📄 Detailed feature descriptions are available in `docs/data_dictionary.md`.

---

## 🛠️ Tech Stack

**Languages**

* Python
* SQL

**Libraries & Tools**

* pandas, numpy
* scikit-learn
* XGBoost / LightGBM
* SHAP
* SQL (SQLite / PostgreSQL)
* Streamlit
* Git & GitHub

---

## 🗂️ Repository Structure

```
healthcare-readmission-ml/
│
├── README.md
├── requirements.txt
├── .env.example
├── config/
│   └── config.yaml
│
├── sql/
│   ├── schema.sql
│   ├── data_load.sql
│   ├── eda_queries.sql
│   └── feature_queries.sql
│
├── src/
│   ├── data/
│   │   ├── ingest.py
│   │   ├── validate.py
│   │   └── split.py
│   │
│   ├── features/
│   │   └── build_features.py
│   │
│   ├── models/
│   │   ├── train.py
│   │   ├── evaluate.py
│   │   └── tune.py
│   │
│   ├── inference/
│   │   └── predict.py
│   │
│   └── utils/
│       └── logger.py
│
├── notebooks/
│   └── 01_eda.ipynb
│
├── app/
│   └── streamlit_app.py
│
└── docs/
    ├── problem_statement.md
    ├── data_dictionary.md
    ├── ml_design_decisions.md
    └── deployment_notes.md
```

> 📌 **Notebooks are used only for exploration.**
> All core logic lives in reusable Python modules.

---

## 🧭 Learning Path (Beginner → Pro)

This repository is structured as a **guided journey**:

1. **Problem Framing & Healthcare Context**
2. **SQL-Based Data Exploration**
3. **Data Cleaning & Validation**
4. **Feature Engineering**
5. **Baseline & Advanced Modeling**
6. **Model Evaluation & Threshold Tuning**
7. **Interpretability (SHAP)**
8. **Deployment & Inference**
9. **Documentation & Ethical Considerations**

Each stage explains:

* *What is being done*
* *Why it matters in real projects*
* *Common beginner mistakes*

---

## 📊 Evaluation Philosophy

In healthcare, **accuracy alone is not enough**.

Primary metrics:

* Recall
* F1-score
* ROC-AUC

Special emphasis is placed on:

* False negatives (missed high-risk patients)
* Model transparency and trust

---

## 🚀 Deployment

A lightweight **Streamlit application** allows users to:

* Input patient details
* Get predicted readmission risk
* Understand which features influenced the decision

This simulates a real internal clinical analytics tool.

---

## 👨‍🎓 Who This Project Is For

* MSc / BSc Data Science students
* Working professionals learning data science
* Anyone confused by scattered tutorials
* Recruiters looking for **proof of real skills**

---

## 📌 Disclaimer

This project is for **educational purposes only**.
It is **not intended for real clinical decision-making**.

---

## 🧭 Roadmap (Planned Extensions)

* CI/CD with GitHub Actions
* Data validation with Great Expectations
* Model versioning
* Basic MLOps concepts

---

## ✨ Author

Built as part of an **MSc in Data Science**, while working professionally—designed to be realistic, practical, and reproducible.

---

# 📋 Week 1 Checklist

## 🎯 Goal: Move From CSV → Structured Database

### Day 1

* [ ] Create repo structure
* [ ] Add README
* [ ] Add problem_statement.md

### Day 2

* [ ] Download dataset
* [ ] Create schema.sql
* [ ] Create admissions table

### Day 3

* [ ] Load data into database
* [ ] Verify row count
* [ ] Run basic SQL queries

Example validation query:

```sql
SELECT COUNT(*) FROM admissions;
```

### Day 4

* [ ] Check target distribution

```sql
SELECT readmitted, COUNT(*)
FROM admissions
GROUP BY readmitted;
```

### Day 5

* [ ] Push to GitHub
* [ ] Write commit messages properly

