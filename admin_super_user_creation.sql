CREATE USER ADMINL_SUPER_USER IDENTIFIED BY NeuBoston2024#;

GRANT CONNECT, RESOURCE TO ADMINL_SUPER_USER;

ALTER USER ADMINL_SUPER_USER QUOTA UNLIMITED ON DATA;