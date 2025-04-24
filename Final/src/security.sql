-- basic roles
CREATE ROLE cs_admins WITH NOLOGIN;
CREATE ROLE cs_app WITH NOLOGIN;
CREATE ROLE cs_readonly WITH NOLOGIN;

-- Create user accounts and assign to groups
-- Very secure passwords !
-- Administrators (full access)
CREATE USER admin1 WITH PASSWORD 'admin_pass1' IN ROLE cs_admins;
-- Application service account
CREATE USER app_service WITH PASSWORD 'app_pass1' IN ROLE cs_app;
-- analysts (read only)
CREATE USER analyst1 WITH PASSWORD 'analyst_pass1' IN ROLE cs_readonly;

-- Grant permissions
-- Admin - full access
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO cs_admins;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO cs_admins;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO cs_admins;
-- App service cannot modify the schema but it can write
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO cs_app;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO cs_app;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO cs_app;
-- analysts just get select and procs
GRANT SELECT ON ALL TABLES IN SCHEMA public TO cs_readonly;
GRANT EXECUTE ON FUNCTION case_opening_stats(TEXT) TO cs_readonly;
GRANT EXECUTE ON FUNCTION market_price_trends(TEXT) TO cs_readonly;
GRANT EXECUTE ON FUNCTION souvenir_items_by_major(TEXT) TO cs_readonly;

-- Create connection limits for security - saw while researching syntax - pretty neat
ALTER ROLE cs_support CONNECTION LIMIT 10;
ALTER ROLE cs_readonly CONNECTION LIMIT 5;
ALTER ROLE cs_app CONNECTION LIMIT 50;
