// server.js
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');

const app = express();

// ===== Middleware =====
app.use(cors());
app.use(express.json());

// Serve static frontend
app.use(express.static(path.join(__dirname, 'src')));
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'src', 'index.html'));
});

// ===== Database Connection =====
const connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'root',      // your MySQL username
  password: '',      // your MySQL password (blank if none)
  database: 'pets'
});

connection.connect(err => {
  if (err) {
    console.error('Error connecting to database:', err.message);
    return;
  }
  console.log('Connected to database');
});

// ===== API Routes =====

// Fetch all customers
app.post("/customers", (req, res) => {
  connection.query('SELECT * FROM customers', (err, results) => {
    if (err) return res.status(500).send('Error fetching data');
    res.json({ results });
  });
});

// Fetch all pets
app.post("/pets", (req, res) => {
  connection.query('SELECT * FROM animals', (err, results) => {
    if (err) return res.status(500).send('Error fetching data');
    res.json({ results });
  });
});

// Fetch vet services
app.post("/vet", (req, res) => {
  connection.query('SELECT * FROM vet_service', (err, results) => {
    if (err) return res.status(500).send('Error fetching data');
    res.json({ results });
  });
});

// Fetch sales & total revenue
app.post("/sales", (req, res) => {
  connection.query('SELECT * FROM petting', (err, r) => {
    if (err) return res.status(500).send('Error fetching data');
    connection.query('SELECT SUM(cost) AS pro FROM petting', (err, r2) => {
      if (err) return res.status(500).send('Error fetching data');
      res.json({ r, r2 });
    });
  });
});

// Fetch caretakers
app.post("/caretaker", (req, res) => {
  connection.query('SELECT * FROM caretaker', (err, results) => {
    if (err) return res.status(500).send('Error fetching data');
    res.json({ results });
  });
});

// Fetch phone numbers
app.post("/phone", (req, res) => {
  const { customerId } = req.body;
  connection.query('SELECT number FROM phone_no WHERE customer_id = ?', [customerId], (err, results) => {
    if (err) return res.status(500).send('Error fetching data');
    res.json({ results });
  });
});

// Fetch food suitable for pets
app.post("/food", (req, res) => {
  const { pet_id } = req.body;
  connection.query('SELECT * FROM food_suitable WHERE pet_id = ?', [pet_id], (err, results) => {
    if (err) return res.status(500).send('Error fetching data');
    res.json({ results });
  });
});

// Fetch notifications
app.post("/notify", (req, res) => {
  connection.query('SELECT * FROM notify', (err, results) => {
    if (err) return res.status(500).send('Error fetching data');
    res.json({ results });
  });
});

// Add a new customer
app.post("/api/customers", (req, res) => {
  const { age, gender, name, address, customer_id, numbers } = req.body;
  if (!age || !gender || !name || !address || !customer_id || !numbers) {
    return res.status(400).json({ error: "Missing required fields" });
  }

  const query = 'INSERT INTO customers (customer_id, age, gender, name, address) VALUES (?, ?, ?, ?, ?)';
  connection.query(query, [customer_id, age, gender, name, address], (err) => {
    if (err) return res.status(500).json({ error: "Failed to insert customer" });

    const phoneNumbers = numbers.map(num => [customer_id, num]);
    connection.query('INSERT INTO phone_no (customer_id, number) VALUES ?', [phoneNumbers], (err2) => {
      if (err2) console.error("Error inserting phone numbers:", err2);
    });

    res.status(201).json({ message: "Customer created successfully" });
  });
});

// Add a new pet
app.post("/api/animals", (req, res) => {
  const { type, breed, weight, age, id, gender, sold, food_suitable } = req.body;
  if (!type || !breed || !weight || !age || !id || !gender || !food_suitable) {
    return res.status(400).json({ error: "Missing required fields" });
  }

  const query = 'INSERT INTO animals (typed, breed, weight, age, pet_id, gender, sold) VALUES (?, ?, ?, ?, ?, ?, ?)';
  connection.query(query, [type, breed, weight, age, id, gender, sold], (err) => {
    if (err) return res.status(500).json({ error: "Failed to insert pet" });

    const foodData = food_suitable.map(item => [id, item]);
    connection.query('INSERT INTO food_suitable (pet_id, suitable) VALUES ?', [foodData], (err2) => {
      if (err2) console.error("Error inserting food suitable:", err2);
    });

    res.status(201).json({ message: "Pet created successfully" });
  });
});

// Add a new transaction (pet sold)
app.post("/api/transactions", (req, res) => {
  const { animalId, customerId, cost, date } = req.body;
  if (!animalId || !customerId || !cost || !date) {
    return res.status(400).json({ error: "Missing required fields" });
  }

  connection.query('INSERT INTO petting (pet_id, customer_id, cost, bought_date) VALUES (?, ?, ?, ?)',
    [animalId, customerId, cost, date], (err) => {
      if (err) return res.status(500).json({ error: "Failed to insert transaction" });
      res.status(201).json({ message: "Transaction recorded successfully" });
    });
});

// ===== Close DB on exit =====
process.on('exit', () => connection.end());

// ===== Start server =====
const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
