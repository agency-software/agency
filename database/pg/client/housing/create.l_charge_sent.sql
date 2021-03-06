CREATE TABLE tbl_l_charge_sent (
	charge_sent_code VARCHAR(10) PRIMARY KEY,
	description VARCHAR(45) NOT NULL UNIQUE,
    --system fields
    added_by                        INTEGER NOT NULL REFERENCES tbl_staff (staff_id),
    added_at                        TIMESTAMP(0)     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed_by                      INTEGER NOT NULL  REFERENCES tbl_staff (staff_id),
    changed_at                      TIMESTAMP(0)     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted                      BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at                      TIMESTAMP(0) CHECK ((NOT is_deleted AND deleted_at IS
 NULL) OR (is_deleted AND deleted_at IS NOT NULL)),
    deleted_by                      INTEGER REFERENCES tbl_staff(staff_id)
                                       CHECK ((NOT is_deleted AND deleted_by IS NULL) OR (is_deleted AND deleted_by IS NOT NULL)),
    deleted_comment         TEXT,
    sys_log                 TEXT
);

INSERT INTO tbl_l_charge_sent VALUES('NEEDSEND','Charge needs to be sent',sys_user(),current_timestamp,sys_user(),current_timestamp);
INSERT INTO tbl_l_charge_sent VALUES('SENT','Charge sent to accounting',sys_user(),current_timestamp,sys_user(),current_timestamp);
INSERT INTO tbl_l_charge_sent VALUES('NOCHARGE','No charge',sys_user(),current_timestamp,sys_user(),current_timestamp);

CREATE VIEW l_charge_sent AS (SELECT * FROM tbl_l_charge_sent WHERE NOT is_deleted);

