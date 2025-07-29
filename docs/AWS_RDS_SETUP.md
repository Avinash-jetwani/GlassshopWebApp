# AWS RDS PostgreSQL Setup Guide

## 🎯 Overview

This guide walks you through setting up AWS RDS PostgreSQL databases for the GlassShopDev project. We'll create two separate RDS instances:
- **Development Database**: For development and testing
- **Live Database**: For production use

## 📋 Prerequisites

- AWS Account with RDS permissions
- AWS CLI installed (optional)
- PostgreSQL client tools (psql, pgAdmin)

---

## 🚀 Step-by-Step Setup

### Step 1: Create Development RDS Instance

#### 1.1 Navigate to RDS
1. Login to **AWS Management Console**
2. Search for "RDS" and click on **Amazon RDS**
3. Click **"Create database"**

#### 1.2 Database Configuration
**Engine Options:**
- **Engine type**: PostgreSQL
- **Edition**: PostgreSQL
- **Version**: PostgreSQL 16.9-R2 (or latest 16.x)

**Templates:**
- Select **"Dev/Test"** template

#### 1.3 Settings
```
DB Instance Identifier: glassshop-dev-db
Master Username: postgres
Master Password: [Choose strong password - save it!]
```

#### 1.4 Instance Configuration
```
DB Instance Class: db.t3.micro (free tier eligible)
Storage Type: General Purpose SSD (gp2)
Allocated Storage: 20 GB
Enable storage autoscaling: ✓
Maximum storage threshold: 50 GB
```

#### 1.5 Connectivity
```
Virtual Private Cloud (VPC): Default VPC
Subnet group: default
Public access: Yes
VPC security groups: Create new
  - Name: glassshop-dev-db-sg
Availability Zone: No preference
Database port: 5432
```

#### 1.6 Additional Configuration
```
Initial database name: glassshop_dev
DB parameter group: default.postgres16
Option group: default:postgres-16
Backup retention period: 7 days
Backup window: No preference
Copy tags to snapshots: ✓
Enable encryption: ✓ (default AWS KMS key)
Enable Enhanced monitoring: ✓
Monitoring role: Default
Enable Performance Insights: ✓
Enable auto minor version upgrade: ✓
Maintenance window: No preference
Enable deletion protection: ✗ (for dev environment)
```

#### 1.7 Create Database
1. Review all settings
2. Click **"Create database"**
3. Wait 10-15 minutes for creation to complete

---

### Step 2: Create Live/Production RDS Instance

#### 2.1 Repeat Process with Production Settings
Follow Step 1 but with these changes:

**Templates:**
- Select **"Production"** template

**Settings:**
```
DB Instance Identifier: glassshop-live-db
Master Username: postgres
Master Password: [Different strong password - save it!]
```

**Instance Configuration:**
```
DB Instance Class: db.t3.small (or larger based on needs)
Multi-AZ deployment: ✓ (for high availability)
Storage Type: General Purpose SSD (gp2)
Allocated Storage: 50 GB
Maximum storage threshold: 100 GB
```

**Connectivity:**
```
Public access: No (access via VPC only for security)
VPC security groups: Create new
  - Name: glassshop-live-db-sg
```

**Additional Configuration:**
```
Initial database name: glassshop_live
Backup retention period: 30 days
Enable deletion protection: ✓ (for production safety)
```

---

### Step 3: Configure Security Groups

#### 3.1 Development Database Security Group
1. Go to **EC2 Console** → **Security Groups**
2. Find `glassshop-dev-db-sg`
3. Edit **Inbound Rules**:
   ```
   Type: PostgreSQL
   Protocol: TCP
   Port: 5432
   Source: Your IP (or 0.0.0.0/0 for development only)
   Description: Dev database access
   ```

#### 3.2 Production Database Security Group
1. Find `glassshop-live-db-sg`
2. Edit **Inbound Rules**:
   ```
   Type: PostgreSQL
   Protocol: TCP
   Port: 5432
   Source: VPC CIDR (e.g., 10.0.0.0/16)
   Description: Production database access from VPC only
   ```

---

### Step 4: Get Database Endpoints

#### 4.1 Retrieve Connection Information
1. Go back to **RDS Console**
2. Click on **"glassshop-dev-db"**
3. In **Connectivity & security** tab, copy:
   - **Endpoint**: `glassshop-dev-db.xxxxxxxxx.us-east-1.rds.amazonaws.com`
   - **Port**: `5432`

4. Repeat for **"glassshop-live-db"**

#### 4.2 Save Connection Details
Create a secure note with:
```
Development Database:
- Endpoint: glassshop-dev-db.xxxxxxxxx.us-east-1.rds.amazonaws.com
- Port: 5432
- Database: glassshop_dev
- Username: postgres
- Password: [your dev password]

Production Database:
- Endpoint: glassshop-live-db.xxxxxxxxx.us-east-1.rds.amazonaws.com
- Port: 5432
- Database: glassshop_live
- Username: postgres
- Password: [your live password]
```

---

### Step 5: Create Application Users

#### 5.1 Connect to Development Database
```bash
psql -h glassshop-dev-db.xxxxxxxxx.us-east-1.rds.amazonaws.com -U postgres -d glassshop_dev
```

#### 5.2 Create Development User
```sql
-- Create application user for development
CREATE USER glassshop_dev_user WITH PASSWORD 'SecureDevPassword123!';

-- Grant necessary privileges
GRANT ALL PRIVILEGES ON DATABASE glassshop_dev TO glassshop_dev_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO glassshop_dev_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO glassshop_dev_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO glassshop_dev_user;

-- Grant future object privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO glassshop_dev_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO glassshop_dev_user;

-- Verify user creation
\du
```

#### 5.3 Connect to Production Database
```bash
psql -h glassshop-live-db.xxxxxxxxx.us-east-1.rds.amazonaws.com -U postgres -d glassshop_live
```

#### 5.4 Create Production User
```sql
-- Create application user for production
CREATE USER glassshop_live_user WITH PASSWORD 'SecureLivePassword123!';

-- Grant necessary privileges
GRANT ALL PRIVILEGES ON DATABASE glassshop_live TO glassshop_live_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO glassshop_live_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO glassshop_live_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO glassshop_live_user;

-- Grant future object privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO glassshop_live_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO glassshop_live_user;

-- Verify user creation
\du
```

---

### Step 6: Test Connections

#### 6.1 Test Development Connection
```bash
psql -h glassshop-dev-db.xxxxxxxxx.us-east-1.rds.amazonaws.com -U glassshop_dev_user -d glassshop_dev
```

#### 6.2 Test Production Connection
```bash
psql -h glassshop-live-db.xxxxxxxxx.us-east-1.rds.amazonaws.com -U glassshop_live_user -d glassshop_live
```

#### 6.3 Basic Database Tests
In each connection, run:
```sql
-- Test basic operations
SELECT version();
SELECT current_database();
SELECT current_user;

-- Test table creation
CREATE TABLE test_table (id SERIAL PRIMARY KEY, name VARCHAR(50));
INSERT INTO test_table (name) VALUES ('test');
SELECT * FROM test_table;
DROP TABLE test_table;
```

---

### Step 7: Update Environment Variables

Update your `.env` file with the actual RDS endpoints:

```env
# AWS RDS Development Database Configuration
DB_ENGINE=django.db.backends.postgresql
DB_NAME=glassshop_dev
DB_USER=glassshop_dev_user
DB_PASSWORD=SecureDevPassword123!
DB_HOST=glassshop-dev-db.xxxxxxxxx.us-east-1.rds.amazonaws.com
DB_PORT=5432

# AWS RDS Live Database Configuration
LIVE_DB_NAME=glassshop_live
LIVE_DB_USER=glassshop_live_user
LIVE_DB_PASSWORD=SecureLivePassword123!
LIVE_DB_HOST=glassshop-live-db.xxxxxxxxx.us-east-1.rds.amazonaws.com
LIVE_DB_PORT=5432

# AWS Configuration
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_DEFAULT_REGION=us-east-1
```

---

## ✅ Verification Checklist

Before proceeding, ensure:

- [ ] Development RDS instance is running
- [ ] Production RDS instance is running
- [ ] Security groups configured correctly
- [ ] Database endpoints retrieved
- [ ] Application users created successfully
- [ ] Test connections successful
- [ ] Environment variables updated

---

## 💰 Cost Considerations

**Development Database (db.t3.micro):**
- ~$13-15/month
- Eligible for AWS Free Tier (12 months)

**Production Database (db.t3.small with Multi-AZ):**
- ~$50-70/month
- Additional costs for backups and monitoring

**Cost Optimization Tips:**
- Use Reserved Instances for production (up to 60% savings)
- Enable automated backups cleanup
- Monitor storage usage
- Consider scaling down dev instance when not in use

---

## 🔒 Security Best Practices

1. **Never use default passwords**
2. **Restrict security group access**
3. **Enable encryption at rest**
4. **Enable SSL/TLS for connections**
5. **Regular security updates**
6. **Monitor access logs**
7. **Use IAM database authentication when possible**

---

## 🆘 Troubleshooting

### Connection Issues
- Check security group rules
- Verify endpoint and port
- Ensure RDS instance is running
- Check VPC and subnet configuration

### Permission Issues
- Verify user privileges
- Check database ownership
- Ensure schema permissions

### Performance Issues
- Monitor CloudWatch metrics
- Check connection pooling
- Review query performance
- Consider instance scaling

---

## 📚 Additional Resources

- [AWS RDS User Guide](https://docs.aws.amazon.com/rds/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [AWS RDS Best Practices](https://docs.aws.amazon.com/rds/latest/userguide/CHAP_BestPractices.html)

---

**Created**: December 2024  
**Updated**: December 2024 