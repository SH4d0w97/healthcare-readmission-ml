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

- Class imbalance
- Healthcare-appropriate evaluation metrics
- Model interpretability and trust

---

## 🧠 Why This Project Is Different

Most data science projects stop at _“train a model and show accuracy.”_
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

- Real hospital encounter data
- Demographics, diagnoses, medications, lab results
- Readmission outcome variable
- Messy, imperfect data (just like real life)

📄 Detailed feature descriptions are available in `docs/data_dictionary.md`.

---

## 🛠️ Tech Stack

**Languages**

- Python
- SQL

**Libraries & Tools**

- pandas, numpy
- scikit-learn
- XGBoost / LightGBM
- SHAP
- SQL (SQLite / PostgreSQL)
- Streamlit
- Git & GitHub

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

- _What is being done_
- _Why it matters in real projects_
- _Common beginner mistakes_

---

## 📊 Evaluation Philosophy

In healthcare, **accuracy alone is not enough**.

Primary metrics:

- Recall
- F1-score
- ROC-AUC

Special emphasis is placed on:

- False negatives (missed high-risk patients)
- Model transparency and trust

---

## 🚀 Deployment

A lightweight **Streamlit application** allows users to:

- Input patient details
- Get predicted readmission risk
- Understand which features influenced the decision

This simulates a real internal clinical analytics tool.

---

## 👨‍🎓 Who This Project Is For

- MSc / BSc Data Science students
- Working professionals learning data science
- Anyone confused by scattered tutorials
- Recruiters looking for **proof of real skills**

---

## 📌 Disclaimer

This project is for **educational purposes only**.
It is **not intended for real clinical decision-making**.

---

## 🧭 Roadmap (Planned Extensions)

- CI/CD with GitHub Actions
- Data validation with Great Expectations
- Model versioning
- Basic MLOps concepts

---

## ✨ Author

Built as part of an **MSc in Data Science**, while working professionally—designed to be realistic, practical, and reproducible.

---

# 📋 Week 1 Checklist

## 🎯 Goal: Move From CSV → Structured Database

### Day 1

- [ ] Create repo structure
- [ ] Add README
- [ ] Add problem_statement.md

### Day 2

- [ ] Download dataset
- [ ] Create schema.sql
- [ ] Create admissions table

### Day 3

- [ ] Load data into database
- [ ] Verify row count
- [ ] Run basic SQL queries

Example validation query:

```sql
SELECT COUNT(*) FROM admissions;
```

### Day 4

- [ ] Check target distribution

```sql
SELECT readmitted, COUNT(*)
FROM admissions
GROUP BY readmitted;
```

### Day 5

- [ ] Push to GitHub
- [ ] Push to GitHub
- [ ] Write commit messages properly

---

## 🗄️ Database Setup — From Installed to Working

> **Goal:** Move from a freshly installed PostgreSQL → a populated, queryable project database.

---

### ✅ Step 1 — Verify PostgreSQL Is Running

Open **Command Prompt / Terminal** and run:

```bash
psql -U postgres
```

If prompted, enter the password you set during installation.

If successful, you'll see:

```
postgres=#
```

> 📝 **Note:** The `postgres=#` prompt confirms you are connected as the superuser inside the PostgreSQL interactive shell (`psql`). All subsequent SQL and `\`-commands in this guide are run from this shell unless stated otherwise.

---

### ✅ Step 2 — Create Your Project Database

Inside `psql`, run:

```sql
CREATE DATABASE healthcare_ml;
```

Then connect to it:

```sql
\c healthcare_ml
```

You should now see:

```
You are now connected to database "healthcare_ml".
```

> 📝 **Note:** `\c` is a `psql` meta-command (not standard SQL) that switches your active connection to the specified database. All subsequent operations will target `healthcare_ml`.

---

### ✅ Step 3 — Create Project Folder Structure

On your local machine, your project directory should look like:

```
healthcare-readmission-ml/
│
├── data/
│   └── raw/
│       └── diabetic_data.csv      ← dataset goes here
│
├── sql/
│   └── schema.sql
│
└── docs/
```

> 📝 **Note:** Keeping raw data in `data/raw/` and never modifying it is a best practice. It preserves the original source so you can always re-run the pipeline from scratch.

---

### ✅ Step 4 — Create `schema.sql`

Create the file `sql/schema.sql` and paste the following:

```sql
-- Drop table if it exists (safe re-run)
DROP TABLE IF EXISTS admissions;

-- Core admissions table matching the UCI dataset columns
DROP TABLE IF EXISTS admissions;

CREATE TABLE admissions (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(20),
    age VARCHAR(20),
    weight VARCHAR(20),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    payer_code VARCHAR(20),
    medical_specialty VARCHAR(100),
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_emergency INT,
    number_inpatient INT,
    diag_1 VARCHAR(20),
    diag_2 VARCHAR(20),
    diag_3 VARCHAR(20),
    number_diagnoses INT,
    max_glu_serum VARCHAR(20),
    A1Cresult VARCHAR(20),
    metformin VARCHAR(20),
    repaglinide VARCHAR(20),
    nateglinide VARCHAR(20),
    chlorpropamide VARCHAR(20),
    glimepiride VARCHAR(20),
    acetohexamide VARCHAR(20),
    glipizide VARCHAR(20),
    glyburide VARCHAR(20),
    tolbutamide VARCHAR(20),
    pioglitazone VARCHAR(20),
    rosiglitazone VARCHAR(20),
    acarbose VARCHAR(20),
    miglitol VARCHAR(20),
    troglitazone VARCHAR(20),
    tolazamide VARCHAR(20),
    examide VARCHAR(20),
    citoglipton VARCHAR(20),
    insulin VARCHAR(20),
    glyburide_metformin VARCHAR(20),
    glipizide_metformin VARCHAR(20),
    glimepiride_pioglitazone VARCHAR(20),
    metformin_rosiglitazone VARCHAR(20),
    metformin_pioglitazone VARCHAR(20),
    change VARCHAR(10),
    diabetesMed VARCHAR(10),
    readmitted VARCHAR(10)
);
```

> 📝 **Note:** `DROP TABLE IF EXISTS` makes the script safely re-runnable — if you re-execute the schema, it won't error on an existing table. This is standard practice in data engineering.

---

### ✅ Step 5 — Execute the Schema

Inside `psql` (connected to `healthcare_ml`), run:

```sql
\i /absolute/path/to/sql/schema.sql
```

**Windows example:**

```sql
\i C:/Users/YourName/healthcare-readmission-ml/sql/schema.sql
```

> ⚠️ **Windows tip:** Use **forward slashes** (`/`), not backslashes (`\`), in `psql` path arguments.

If successful, you'll see:

```
DROP TABLE
CREATE TABLE
```

---

### ✅ Step 6 — Load the Dataset

Use `\copy` (the `psql` client-side command) to import the CSV:

```sql
\copy admissions FROM '/absolute/path/to/data/raw/diabetic_data.csv' DELIMITER ',' CSV HEADER;
```

**Windows example:**

```sql
\copy admissions FROM 'C:/Users/YourName/healthcare-readmission-ml/data/raw/diabetic_data.csv' DELIMITER ',' CSV HEADER;
```

If successful, you'll see:

```
COPY 101766
```

> 📝 **Note:** `\copy` runs on the _client_ side (your machine), whereas server-side `COPY` requires the file to be on the PostgreSQL server. For local development, always prefer `\copy`.

---

### ✅ Step 7 — Validate the Load

**Check total row count:**

```sql
SELECT COUNT(*) FROM admissions;
```

Expected: **~101,766 rows**

**Check target label distribution:**

```sql
SELECT readmitted, COUNT(*) AS count
FROM admissions
GROUP BY readmitted
ORDER BY count DESC;
```

Expected result (approximate):

| readmitted | count  |
| ---------- | ------ |
| NO         | 54,864 |
| >30        | 35,545 |
| <30        | 11,357 |

> 📝 **Note:** The class imbalance here (the `<30` readmission class is a minority) is a key challenge this project addresses. This distribution will guide your choice of evaluation metrics and resampling strategy.

---

### 🧠 What You Just Built

```
Raw CSV  →  Structured relational table  →  Queryable healthcare dataset
```

You've done what most students skip — loaded real data into a proper database before touching Python. This makes your analysis reproducible, scalable, and far more professional than notebook-only workflows.

---

# 📊 Week 2 — Professional SQL EDA

This is where you stop being a student and start thinking like a healthcare analyst.

---

# 🎯 Objective of This Phase

Before touching Python:

We must answer:

1. What does our target distribution look like?
2. Is there class imbalance?
3. Are there obvious data quality problems?
4. Are there potential leakage variables?
5. What early healthcare insights can we extract?

Everything starts with SQL.

---

# 📁 Create: `sql/eda_queries.sql`

Inside:

```
sql/eda_queries.sql
```

We’ll build this step by step.

---

# 🔎 1️⃣ Target Distribution (Critical)

```sql
SELECT 
    readmitted,
    COUNT(*) AS patient_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM admissions
GROUP BY readmitted
ORDER BY patient_count DESC;
```

---

### 🧠 What You’re Checking

Values should be:

* NO
* <30
* > 30

We care about `<30`.

You will likely see:

* NO ≈ 50–55%
* > 30 ≈ 30–35%
* <30 ≈ 10–12%

This means:

🚨 Severe class imbalance.

Accuracy will be misleading.

---

# 🔍 2️⃣ Missing Value Inspection

In this dataset, missing values are often stored as:

```
?
```

Check race:

```sql
SELECT race, COUNT(*)
FROM admissions
GROUP BY race
ORDER BY COUNT(*) DESC;
```

You’ll see `?`.

Now count missing values explicitly:

```sql
SELECT COUNT(*) 
FROM admissions
WHERE race = '?';
```

---

### 🧠 Why This Matters

In real healthcare systems:

* Missing race can impact fairness analysis
* Missing payer_code can impact billing interpretation

We don’t drop blindly.

---

# 🔎 3️⃣ Length of Stay Distribution

```sql
SELECT 
    time_in_hospital,
    COUNT(*) AS count
FROM admissions
GROUP BY time_in_hospital
ORDER BY time_in_hospital;
```

---

### Think:

* Does longer stay increase readmission risk?

Test:

```sql
SELECT 
    readmitted,
    AVG(time_in_hospital) AS avg_stay
FROM admissions
GROUP BY readmitted;
```

---

This is your first real analytical insight.

---

# 🔎 4️⃣ Previous Admissions (Strong Signal Candidate)

```sql
SELECT 
    readmitted,
    AVG(number_inpatient) AS avg_prior_inpatient
FROM admissions
GROUP BY readmitted;
```

If `<30` has higher prior admissions:

That’s a powerful predictive feature.

---

# 🔎 5️⃣ Check for Duplicate Patients

Very important.

```sql
SELECT 
    patient_nbr,
    COUNT(*) AS visit_count
FROM admissions
GROUP BY patient_nbr
HAVING COUNT(*) > 1
ORDER BY visit_count DESC;
```

This dataset has repeat patients.

This creates a serious ML design question:

👉 Should we split train/test by encounter or by patient?

(We’ll handle this properly later.)

---

# 🔎 6️⃣ Inspect Discharge Disposition (Leakage Risk)

```sql
SELECT 
    discharge_disposition_id,
    COUNT(*)
FROM admissions
GROUP BY discharge_disposition_id
ORDER BY COUNT(*) DESC;
```

Some discharge codes may imply:

* Death
* Transfer
* Hospice

If a patient died, they obviously won’t be readmitted.

That can cause data leakage.

We’ll handle that carefully later.

---

# 🧠 What You’re Learning Right Now

You’re not:
“running queries.”

You’re:

* Thinking causally
* Thinking about bias
* Thinking about leakage
* Thinking about ML consequences

This is professional-level thinking.

---

# 📌 Your Task Now

Run:

1. Target distribution query
2. Average stay by readmission
3. Average prior inpatient visits by readmission

Then tell me:

* What % is `<30`?
* Is avg stay higher for `<30`?
* Is number_inpatient higher for `<30`?


