show tables;
desc customer;

-- DB 2개 생성 예정
-- 영업점 DB
-- 영업점ID, 영업점이름
CREATE TABLE branch (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL
);

-- 고객 DB
-- 고객ID, 고객이름, 고객전화번호, 고객이메일, 고객주소, 고객상세주소, 
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(2000),
    address_detail VARCHAR(2000),
    registered_date DATE, 
    register_id VARCHAR(20), -- 등록한 사람
    updated_date DATE,
    updater_id VARCHAR(20), -- 수정한 사람
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

SELECT * FROM branch;

INSERT INTO branch(branch_id, branch_name) VALUES (1, "가산지점");
INSERT INTO branch(branch_id, branch_name) VALUES (2, "일산지점");
INSERT INTO branch(branch_id, branch_name) VALUES (3, "울산지점");
INSERT INTO branch(branch_id, branch_name) VALUES (4, "부산지점");\

SELECT * FROM customer;

INSERT INTO customer(name, phone, email, address, address_detail, registered_date, register_id, updated_date, updater_id, branch_id)
VALUES("김민정", "01011111111", "aaa@example.com", "경기도 고양시", "100동 100호", NOW(), "alswjd",  NOW(), "alswjd", 2);

INSERT INTO customer(name, phone, email, address, address_detail, registered_date, register_id, updated_date, updater_id, branch_id)
VALUES("홍홍홍", "01022222222", "bbb@example.com", "경기도 부천시", "200동 200호", NOW(), "honghong",  NOW(), "honghong", 3);

INSERT INTO customer(name, phone, email, address, address_detail, registered_date, register_id, updated_date, updater_id, branch_id)
VALUES("홍홍홍", "01022222222", "bbb@example.com", "경기도 부천시", "200동 200호", NOW(), "honghong",  NOW(), "honghong", 3);

INSERT INTO customer(name, phone, email, address, address_detail, registered_date, register_id, updated_date, updater_id, branch_id)
VALUES("홍홍홍", "01022222222", "bbb@example.com", "경기도 부천시", "200동 200호", NOW(), "honghong",  NOW(), "honghong", 3);

INSERT INTO customer(name, phone, email, address, address_detail, registered_date, register_id, updated_date, updater_id, branch_id)
VALUES("이부산", "01044444444", "ddd@example.com", "부산광역시", "400동 400호", NOW(), "busan",  NOW(), "busan", 4);

INSERT INTO customer(name, phone, email, address, address_detail, registered_date, register_id, updated_date, updater_id, branch_id)
VALUES("김가산", "01099999999", "ccc@example.com", "서울광역시 금천구 가산동", "가산어반워크 5층", NOW(), "gasan",  NOW(), "gasan", 1);