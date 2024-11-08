SET SERVEROUTPUT ON;
-- CANDIDATE USER creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM ALL_USERS
    WHERE USERNAME = 'CANDIDATE';
    
    IF ROWS_COUNT > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER CANDIDATE CASCADE';
        dbms_output.put_line('"CANDIDATE" user dropped.');
    END IF;
    EXECUTE IMMEDIATE 'CREATE USER CANDIDATE IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO CANDIDATE';
    
    -- Access to tables
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON USERS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON ADDRESS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON CANDIDATES TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON WORK_EXP TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON EDUCATION TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON RESUME TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON SKILLS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, DELETE ON CANDIDATE_SKILLS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON COMPANIES TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON RECRUITERS TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOB_REQUISITION TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON CANDIDATE_APPLICATION TO CANDIDATE';
    
    -- Acccess to views
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOBS_APPLIED_HISTORY TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT ON JOBS_OPEN TO CANDIDATE';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON CANDIDATE_PROFILE TO CANDIDATE';
    dbms_output.put_line('"CANDIDATE" user created successfully.');
    
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/


-- RECRUITER USER creation
DECLARE
    ROWS_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO ROWS_COUNT
    FROM ALL_USERS
    WHERE USERNAME = 'RECRUITER';
    
    IF ROWS_COUNT > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER RECRUITER CASCADE';
        dbms_output.put_line('"RECRUITER" user dropped.');
    END IF;
    EXECUTE IMMEDIATE 'CREATE USER RECRUITER IDENTIFIED BY NeuBoston2024#';
    EXECUTE IMMEDIATE 'GRANT CONNECT TO RECRUITER';
    
     -- Access to tables
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON USERS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON ADDRESS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATES TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON WORK_EXP TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON EDUCATION TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON RESUME TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON SKILLS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATE_SKILLS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON COMPANIES TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON RECRUITERS TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE ON JOB_REQUISITION TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON CANDIDATE_APPLICATION TO RECRUITER';
    
    -- Acccess to views
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON JOBS_CREATED_HISTORY TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT ON CANDIDATES_JOBS_APPLIED TO RECRUITER';
    EXECUTE IMMEDIATE 'GRANT SELECT, UPDATE ON JOBS_OPEN TO RECRUITER';
    dbms_output.put_line('"RECRUITER" user created successfully.');
    
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong: Error Code ' || SQLCODE || ' - ' || SQLERRM);
END;
/