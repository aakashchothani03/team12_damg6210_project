-- CLEAN UP SCRIPT FILE

-- "USERS" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE USERS';
    dbms_output.put_line(' TABLE USERS DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "CANDIDATES" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CANDIDATES';
    dbms_output.put_line(' TABLE CANDIDATES DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "WORK_EXP" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE WORK_EXP';
    dbms_output.put_line(' TABLE WORK_EXP DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "COMPANIES" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE COMPANIES';
    dbms_output.put_line(' TABLE COMPANIES DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "RECRUITERS" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE RECRUITERS';
    dbms_output.put_line(' TABLE RECRUITERS DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "SKILLS" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SKILLS';
    dbms_output.put_line(' TABLE SKILLS DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "EDUCATION" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE EDUCATION';
    dbms_output.put_line(' TABLE EDUCATION DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "JOB_REQUISITION" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE JOB_REQUISITION';
    dbms_output.put_line(' TABLE JOB_REQUISITION DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "ADDRESS" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ADDRESS';
    dbms_output.put_line(' TABLE ADDRESS DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "RESUME" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE RESUME';
    dbms_output.put_line(' TABLE RESUME DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/

-- "JOB_REQUISITION" TABLE
SET SERVEROUTPUT ON;
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE JOB_REQUISITION';
    dbms_output.put_line(' TABLE JOB_REQUISITION DROPPED SUCCESSFULLY ');
EXCEPTION
    WHEN OTHERS THEN
        IF sqlcode = -942 THEN
        dbms_output.put_line(' GOOD TO GO TO NEXT SCRIPT ');
        ELSE
        RAISE;
        END IF;
END;
/









