-- ============================================================
-- FOOD DELIVERY PERFORMANCE & CUSTOMER ANALYTICS PIPELINE
-- Roll Number: 23052151
-- Project Setup
-- ============================================================

-- Create project schema
CREATE SCHEMA IF NOT EXISTS workspace.capstone_23052151;

-- Create Bronze/Raw/Silver/Gold volumes
CREATE VOLUME IF NOT EXISTS workspace.capstone_23052151.raw_data;

CREATE VOLUME IF NOT EXISTS workspace.capstone_23052151.bronze_data;

CREATE VOLUME IF NOT EXISTS workspace.capstone_23052151.silver_data;

CREATE VOLUME IF NOT EXISTS workspace.capstone_23052151.gold_data;

-- Verify schema
SHOW SCHEMAS IN workspace;

-- Verify volumes
SHOW VOLUMES IN workspace.capstone_23052151;