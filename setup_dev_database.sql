-- =================================================
-- Development Database Setup Script
-- Database: glassshop_dev
-- Endpoint: glassshop-dev-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com
-- =================================================

-- Connect to: glassshop-dev-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com
-- Database: glassshop_dev  
-- Username: postgres
-- Password: AeGlazingTest!2025

-- 1. Create application user for development
CREATE USER glassshop_dev_user WITH PASSWORD 'SecureDevPassword123!';

-- 2. Grant necessary privileges
GRANT ALL PRIVILEGES ON DATABASE glassshop_dev TO glassshop_dev_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO glassshop_dev_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO glassshop_dev_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO glassshop_dev_user;

-- 3. Grant future object privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO glassshop_dev_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO glassshop_dev_user;

-- 4. Verify user creation
SELECT usename, usesuper, usecreatedb FROM pg_user WHERE usename = 'glassshop_dev_user';

-- 5. Test basic operations
SELECT version();
SELECT current_database();
SELECT current_user;

-- 6. Test table creation (you can delete this test table after)
CREATE TABLE test_dev_table (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. Test data insertion
INSERT INTO test_dev_table (name) VALUES ('Development Test');

-- 8. Test data selection
SELECT * FROM test_dev_table;

-- 9. Drop test table
DROP TABLE test_dev_table;

-- 10. Final verification
SELECT 'Development database setup completed successfully!' as status; 