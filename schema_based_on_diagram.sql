CREATE TABLE patients(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(200),
	date_of_birth DATE,
	PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
	id INT GENERATED ALWAYS AS IDENTITY,
	admitted_at TIMESTAMP,
	patient_id INT,
	status VARCHAR(100),
	PRIMARY KEY(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);
CREATE INDEX patient_id_index ON medical_histories(patient_id asc);

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
	medical_history_id INT,
	PRIMARY KEY(id),
	FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);
CREATE INDEX medical_history_id_index ON invoices(medical_history_id asc);


CREATE TABLE invoice_items(
	id INT GENERATED ALWAYS AS IDENTITY,
	unit_price DECIMAL(5, 2),
	quantity INT,
	total_price DECIMAL(5, 2),
	invoice_id INT ,
	treatment_id INT,
	PRIMARY KEY(id),
	FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);
CREATE INDEX invoice_treatment_index ON invoice_items(invoice_id, treatment_id asc);

CREATE TABLE med_treatment_history(
	id INT GENERATED ALWAYS AS IDENTITY,
	med_history_id INT,
	treatment_id INT,
	PRIMARY KEY(id)
	FOREIGN KEY (med_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatments_id) REFERENCES treatments(id)
);
CREATE INDEX medical_histories_treatments_index ON med_treatment_history(med_history_id, treatments_id asc);
