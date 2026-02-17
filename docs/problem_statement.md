# Problem Statement

## Business Context

Hospital readmissions within 30 days of discharge are costly and often
indicate gaps in care quality. Predicting high-risk patients enables:

- Early intervention
- Resource optimization
- Improved patient outcomes
- Reduced hospital penalties

---

## Objective

Build a machine learning model that predicts whether a patient will be
readmitted within 30 days of discharge.

This is framed as a binary classification problem:

- 1 → Readmitted within 30 days
- 0 → Not readmitted within 30 days

---

## Success Criteria

The model should:

- Achieve strong recall for high-risk patients
- Maintain acceptable precision
- Be interpretable
- Be deployable in a lightweight environment

---

## Key Challenges

- Class imbalance
- Missing values
- Categorical-heavy dataset
- Risk of data leakage
- Ethical considerations in healthcare AI

---

## Evaluation Metrics

Primary:
- Recall
- F1 Score
- ROC-AUC

Why recall matters:
Missing a high-risk patient (false negative) is more dangerous than
flagging a low-risk one.

---

## Ethical Note

This model is for educational purposes only.
It is not intended for clinical decision-making.
