-- Migration: Create role_change_logs table
CREATE TABLE role_change_logs (
    role_change_log_id bigserial PRIMARY KEY,
    user_id bigint REFERENCES users(user_id) ON DELETE SET NULL,
    changed_by_id bigint REFERENCES users(user_id) ON DELETE SET NULL,
    action varchar(50) NOT NULL,
    old_role_id bigint,
    new_role_id bigint,
    user_group_id bigint,
    context_id bigint,
    metadata jsonb,
    ip_address varchar(255),
    user_agent text,
    inserted_at timestamp(0) without time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp(0) without time zone NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_role_change_logs_user_id ON role_change_logs(user_id);
CREATE INDEX idx_role_change_logs_changed_by_id ON role_change_logs(changed_by_id);
CREATE INDEX idx_role_change_logs_action ON role_change_logs(action);
CREATE INDEX idx_role_change_logs_context_id ON role_change_logs(context_id);
CREATE INDEX idx_role_change_logs_inserted_at ON role_change_logs(inserted_at);