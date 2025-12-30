use pets;
create table animals(
    pet_id int,
    age int,
    gender varchar(40),
    typed varchar(40),
    breed varchar(40),
    sold int,
    weight int,
    primary key(pet_id)
);

INSERT INTO animals (pet_id, age, gender, typed, breed, sold, weight)
VALUES
(1, 2, 'Male', 'Dog', 'Labrador Retriever', 0, 10),
(2, 1, 'Female', 'Cat', 'Siamese', 1, 5),
(3, 3, 'Male', 'Dog', 'German Shepherd', 0, 12),
(4, 1, 'Male', 'Dog', 'Golden Retriever', 1, 8),
(5, 2, 'Female', 'Cat', 'Persian', 0, 6);

INSERT INTO animals (pet_id, age, gender, typed, breed, sold, weight)
VALUES
(6, 4, 'Male', 'Dog', 'Poodle', 1, 7),
(7, 1, 'Female', 'Cat', 'Maine Coon', 0, 9),
(8, 2, 'Male', 'Dog', 'Bulldog', 1, 15),
(9, 3, 'Female', 'Dog', 'Beagle', 0, 11),
(10, 1, 'Male', 'Cat', 'Russian Blue', 1, 4);

INSERT INTO animals (pet_id, age, gender, typed, breed, sold, weight)
VALUES
    (20, 3, 'Male', 'Dog', 'Labrador', 0, 15),
    (21, 2, 'Female', 'Cat', 'Siamese', 0, 8),
    (22, 1, 'Male', 'Bird', 'Parrot', 1, 1),
    (23, 4, 'Female', 'Dog', 'Poodle', 1, 12),
    (24, 2, 'Male', 'Cat', 'Maine Coon', 0, 10),
    (25, 6, 'Female', 'Dog', 'German Shepherd', 1, 20),
    (26, 1, 'Male', 'Bird', 'Canary', 0, 1),
    (27, 3, 'Male', 'Cat', 'Persian', 0, 9),
    (28, 5, 'Female', 'Dog', 'Golden Retriever', 1, 18),
    (29, 2, 'Male', 'Cat', 'Bengal', 0, 11),
    (30, 4, 'Female', 'Dog', 'Beagle', 1, 16);


create table food_suitable(
	  pet_id int,
	  suitable varchar(40),
      foreign key(pet_id) references animals(pet_id)
);

INSERT INTO food_suitable (pet_id, suitable) VALUES
(1, 'Dry food'),
(1, 'Meat'),
(1, 'Fish');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(2, 'Dry food'),
(2, 'Fish');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(3, 'Dry food'),
(3, 'Meat');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(4, 'Dry food'),
(4, 'Fish');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(5, 'Dry food'),
(5, 'Meat'),
(5, 'Fish');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(6, 'Dry food'),
(6, 'Meat');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(7, 'Dry food'),
(7, 'Fish');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(8, 'Dry food'),
(8, 'Meat');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(9, 'Dry food'),
(9, 'Fish');

INSERT INTO food_suitable (pet_id, suitable) VALUES
(10, 'Dry food'),
(10, 'Meat'),
(10, 'Fish');

create table caretaker(
         name varchar(40),
         caretaker_id int,
         age int,
         salary int,
		 primary key(caretaker_id)
);

INSERT INTO caretaker (name, caretaker_id, age, salary) VALUES
('Alice', 1, 30, 30000),
('Bob', 2, 35, 35000),
('Charlie', 3, 25, 28000),
('David', 4, 40, 40000),
('Eve', 5, 28, 32000),
('Frank', 6, 45, 38000),
('Grace', 7, 32, 33000),
('Hannah', 8, 27, 29000),
('Ivy', 9, 33, 31000),
('Jack', 10, 38, 36000);


-- SET SQL_SAFE_UPDATES = 0;
update animals set sold=0 where sold=1;



create table vet_service(
	  pet_id int,
      caretaker_id int ,
      removed_fur_days int,
      last_bath int,
      checkup_days int,
	  foreign key(pet_id) references animals(pet_id),
	  foreign key(caretaker_id) references caretaker(caretaker_id),
      primary key(pet_id,caretaker_id)
);

INSERT INTO vet_service (pet_id, caretaker_id, removed_fur_days, last_bath, checkup_days) VALUES
(1, 1, 30, 5, 20),
(2, 2, 25, 4, 25),
(3, 3, 20, 3, 28),
(4, 4, 35, 2, 22),
(5, 5, 40, 1, 29),
(6, 6, 15, 6, 19),
(7, 7, 10, 7, 18),
(8, 8, 5, 8, 17),
(9, 9, 45, 9, 16),
(10, 10, 50, 10, 15);

INSERT INTO vet_service (pet_id, caretaker_id, removed_fur_days, last_bath, checkup_days)
VALUES
    (20, 1, 20, 0, 16),
    (21, 2, 22, 1, 25),
    (22, 3, 24, 2, 20),
    (23, 4, 26, 3, 27),
    (24, 5, 28, 4, 28),
    (25, 6, 30, 5, 9),
    (26, 7, 32, 6, 18),
    (27, 8, 34, 7, 7),
    (28, 9, 36, 8, 22),
    (29, 10,38, 9, 11),
    (30, 1, 40, 10, 26);


create table customers(
    customer_id int,
    age int,
    gender varchar(40),
    name varchar(40),
    address varchar(40),
    primary key(customer_id)
);


-- Inserting additional sample data into the customers table
INSERT INTO customers (customer_id, age, gender, name, address) VALUES
(5, 40, 'Male', 'Robert Johnson', '222 Cedar St'),
(6, 22, 'Female', 'Emma Wilson', '333 Maple St'),
(7, 45, 'Male', 'William Taylor', '444 Birch St'),
(8, 32, 'Female', 'Sophia Martinez', '555 Walnut St'),
(9, 27, 'Male', 'Daniel Anderson', '666 Pine St'),
(10, 38, 'Female', 'Olivia Garcia', '777 Oak St'),
(11, 29, 'Male', 'Alexander Hernandez', '888 Elm St'),
(12, 33, 'Female', 'Isabella Lopez', '999 Main St'),
(13, 36, 'Male', 'James Gonzalez', '111 Pine St'),
(14, 26, 'Female', 'Mia Wilson', '222 Elm St'),
(15, 42, 'Male', 'David Perez', '333 Oak St'),
(16, 24, 'Female', 'Charlotte Lee', '444 Cedar St'),
(17, 31, 'Male', 'Ethan Moore', '555 Maple St'),
(18, 39, 'Female', 'Ava Davis', '666 Birch St'),
(19, 28, 'Male', 'Michael Jackson', '777 Walnut St'),
(20, 37, 'Female', 'Samantha Taylor', '888 Cedar St'),
(21, 34, 'Male', 'Matthew Brown', '999 Pine St'),
(22, 23, 'Female', 'Abigail Clark', '111 Main St'),
(23, 41, 'Male', 'Joseph White', '222 Oak St'),
(24, 25, 'Female', 'Ella Moore', '333 Cedar St');



create table petting(
   pet_id int,
   customer_id int,
   cost int,
   bought_date varchar(40),
   foreign key(pet_id) references animals(pet_id),
   foreign key(customer_id) references customers(customer_id),
   primary key(pet_id,customer_id)
);

INSERT INTO petting (pet_id, customer_id, cost, bought_date) VALUES
(1, 5, 500, '2023-01-15'),
(2, 6, 600, '2023-02-20'),
(3, 7, 700, '2023-03-25'),
(4, 8, 800, '2023-04-30'),
(5, 9, 900, '2023-05-05'),
(6, 10, 1000, '2023-06-10'),
(7, 11, 1100, '2023-07-15'),
(8, 12, 1200, '2023-08-20'),
(9, 13, 1300, '2023-09-25'),
(10, 14, 1400, '2023-10-30');

create table phone_no(
       customer_id int,
       number varchar(15),
       foreign key(customer_id) references customers(customer_id)
);

-- Add multiple phone numbers for all customers
INSERT INTO phone_no (customer_id, number) VALUES
(5, '555-1234'),
(5, '555-5678'),
(5, '555-9012'),
(6, '555-3456'),
(6, '555-7890'),
(7, '555-2345'),
(7, '555-6789'),
(8, '555-0123'),
(8, '555-4567'),
(9, '555-8901'),
(10, '555-2345'),
(10, '555-6789'),
(11, '555-0123'),
(11, '555-4567'),
(12, '555-8901'),
(13, '555-2345'),
(13, '555-6789'),
(14, '555-0123'),
(14, '555-4567'),
(15, '555-8901'),
(16, '555-2345'),
(16, '555-6789'),
(17, '555-0123'),
(17, '555-4567'),
(18, '555-8901'),
(19, '555-2345'),
(19, '555-6789'),
(20, '555-0123'),
(20, '555-4567'),
(21, '555-8901'),
(22, '555-2345'),
(22, '555-6789'),
(23, '555-0123'),
(23, '555-4567'),
(24, '555-8901');

create table notify(
	pet_id int,
	work varchar(50),
    foreign key(pet_id) references animals(pet_id)
);