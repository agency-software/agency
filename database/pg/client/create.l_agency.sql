CREATE TABLE tbl_l_agency (
	agency_code	VARCHAR(10) PRIMARY KEY, --use king county and mixed
	king_cty_code VARCHAR(4),
	description	VARCHAR(60) NOT NULL UNIQUE,
	agency_category_code VARCHAR(10),
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

CREATE VIEW l_agency AS SELECT * FROM tbl_l_agency WHERE NOT is_deleted;

INSERT INTO tbl_l_agency VALUES ('DESC','152','Downtown Emergency Service Center','ALL',sys_user(),current_timestamp,sys_user(),current_timestamp);

