-- =================================================
-- Live Database Setup Script
-- Database: glassshop_live  
-- Endpoint: glassshop-live-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com
-- =================================================

-- Connect to: glassshop-live-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com
-- Database: glassshop_live
-- Username: postgres  
-- Password: AeGlazingLive!2025

-- 1. Create application user for live/production
CREATE USER glassshop_live_user WITH PASSWORD 'SecureLivePassword123!';

-- 2. Grant necessary privileges
GRANT ALL PRIVILEGES ON DATABASE glassshop_live TO glassshop_live_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO glassshop_live_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO glassshop_live_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO glassshop_live_user;

-- 3. Grant future object privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO glassshop_live_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO glassshop_live_user;

-- 4. Verify user creation
SELECT usename, usesuper, usecreatedb FROM pg_user WHERE usename = 'glassshop_live_user';

-- 5. Test basic operations
SELECT version();
SELECT current_database();
SELECT current_user;

-- 6. Test table creation (you can delete this test table after)
CREATE TABLE test_live_table (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. Test data insertion  
INSERT INTO test_live_table (name) VALUES ('Live Database Test');

-- 8. Test data selection
SELECT * FROM test_live_table;

-- 9. Drop test table
DROP TABLE test_live_table;

-- 10. Final verification
SELECT 'Live database setup completed successfully!' as status; 