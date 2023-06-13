CREATE TABLE patients(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(200),
	date_of_birth DATE,
	PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
	id INT GENERATED ALWAYS AS IDENTITY,
	admmited_at TIMESTAMP,
	patient_id INT REFERENCES patients(id),
	status VARCHAR(100),
	PRIMARY KEY(id)
);

CREATE TABLE treatments(
	id INT GENERATED ALWAYS AS IDENTITY,
	type VARCHAR(100),
	name VARCHAR(200),
	PRIMARY KEY(id)
);

CREATE TABLE invoices(
	id INT GENERATED ALWAYS AS IDENTITY,
	total_amount DECIMAL(5, 2),
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INT REFERENCES medical_histories(id),
	PRIMARY KEY(id)
);

CREATE TABLE invoice_items(
	id INT GENERATED ALWAYS AS IDENTITY,
	unit_price DECIMAL(5, 2),
	quantity INT,
	total_price DECIMAL(5, 2),
	invoice_id INT REFERENCES invoices(id),
	treatment_id INT REFERENCES treatments(id),
	PRIMARY KEY(id)
);

CREATE TABLE med_treatment_history(
	id INT GENERATED ALWAYS AS IDENTITY,
	med_history_id INT REFERENCES medical_histories(id),
	treatment_id INT REFERENCES treatments(id),
	PRIMARY KEY(id)
);