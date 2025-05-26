# ML_exec_PGDB
sudo yum install postgresql-plpython3
prepare your model.pkl in Postgres
# model_create.py
import pickle
from sklearn.linear_model import LogisticRegression

# Step 1: Prepare training data
X = [[0, 0], [1, 1], [1, 0], [0, 1]]
y = [0, 0, 1, 1]

# Step 2: Train the model
model = LogisticRegression()
model.fit(X, y)

# Step 3: Serialize the model to a file
with open("model.pkl", "wb") as f:
    pickle.dump(model, f)

print("✅ model.pkl created successfully.")

create extension in PG:
CREATE EXTENSION plpython3u;

PG function:
CREATE OR REPLACE FUNCTION dev.predict_model(features float8[])
RETURNS float8
AS $$
import pickle

# Load the model once and cache it
if not hasattr(plpy, 'model'):
    with open('/opt/model.pkl', 'rb') as f:
        plpy.model = pickle.load(f)

prediction = plpy.model.predict([features])[0]
return float(prediction)
$$ LANGUAGE plpython3u;

launch pclassifcation:
SELECT diff_days,brand,product_id,price,dev.predict_model(ARRAY[diff_days, price]) AS prediction from dev.sales_input_n
