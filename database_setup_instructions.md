# 🚀 Complete Database Setup Instructions (DBeaver)

## 📋 **Steps to Complete (Run in DBeaver)**

### **Step 1: Fix PostgreSQL Driver (If Needed)**
1. If you see "PostgreSQL driver files are missing":
   - Click **"Download"** in the driver settings popup
   - Wait for download to complete
   - If download fails, go to **Database** → **Driver Manager** → **PostgreSQL** → **Download/Update**

### **Step 2: Add Development Database Connection**
1. Open DBeaver
2. Click **"New Database Connection"** (plug icon) or **Ctrl+Shift+O**
3. Select **PostgreSQL** → **Next**
4. **Connection Settings**:
   - **Server Host**: `glassshop-dev-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com`
   - **Port**: `5432`
   - **Database**: `glassshop_dev`
   - **Username**: `postgres`
   - **Password**: `AeGlazingTest!2025`
   - **Connection Name**: `GlassShop Dev Database`
5. Click **"Test Connection"** to verify
6. Click **"Finish"**

### **Step 3: Add Live Database Connection**
1. Click **"New Database Connection"** again
2. Select **PostgreSQL** → **Next**
3. **Connection Settings**:
   - **Server Host**: `glassshop-live-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com`
   - **Port**: `5432`
   - **Database**: `glassshop_live`
   - **Username**: `postgres`
   - **Password**: `AeGlazingLive!2025`
   - **Connection Name**: `GlassShop Live Database`
4. Click **"Test Connection"** to verify
5. Click **"Finish"**

### **Step 4: Run Development Database Setup**
1. **Connect** to "GlassShop Dev Database" (double-click)
2. Right-click on the connection → **"SQL Editor"** → **"Open SQL Script"**
3. **Copy and paste** the entire content from `setup_dev_database.sql`
4. **Execute the script** (Ctrl+Enter or Execute button)
5. Verify you see **"Development database setup completed successfully!"**

### **Step 5: Run Live Database Setup**
1. **Connect** to "GlassShop Live Database" (double-click)
2. Right-click on the connection → **"SQL Editor"** → **"Open SQL Script"**
3. **Copy and paste** the entire content from `setup_live_database.sql`
4. **Execute the script** (Ctrl+Enter or Execute button)
5. Verify you see **"Live database setup completed successfully!"**

---

## ✅ **Verification Checklist**

### **Infrastructure:**
- [ ] Development RDS instance is running
- [ ] Live RDS instance is running
- [ ] Security groups configured correctly
- [ ] Database endpoints retrieved

### **Database Access:**
- [ ] Can connect to development database via pgAdmin
- [ ] Can connect to live database via pgAdmin
- [ ] Both postgres users working

### **Application Users:**
- [ ] `glassshop_dev_user` created successfully
- [ ] `glassshop_live_user` created successfully
- [ ] All permissions granted correctly
- [ ] Test tables created and dropped successfully

### **Environment Setup:**
- [ ] `.env` file created with correct endpoints
- [ ] `.env` file is in `.gitignore` (secure)
- [ ] All database credentials stored safely

### **Testing:**
- [ ] Test connections successful for both databases
- [ ] Test table creation/insertion/selection working
- [ ] Both databases responding correctly

---

## 🔧 **Connection Test Commands**

After completing the pgAdmin setup, you can test connections with these commands (once psql PATH is fixed):

### **Development Database:**
```bash
psql -h glassshop-dev-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com -U glassshop_dev_user -d glassshop_dev
```

### **Live Database:**
```bash
psql -h glassshop-live-db.cjqiqwsc2ul5.eu-west-2.rds.amazonaws.com -U glassshop_live_user -d glassshop_live
```

---

## 📊 **Current Status**

### ✅ **Completed:**
- [x] RDS instances created (dev & live)
- [x] Security groups configured
- [x] Database endpoints obtained
- [x] `.env` file created with credentials
- [x] SQL setup scripts created

### 🔄 **To Complete:**
- [ ] Run SQL scripts in pgAdmin
- [ ] Test database connections
- [ ] Verify all checklist items

---

## 🎯 **Next Phase After Completion**

Once all checklist items are complete:
1. ✅ **Phase 1 Step 4** will be complete
2. 🚀 **Continue to Step 5**: Environment Variables Setup
3. 🛠️ **Continue to Step 6**: VS Code Setup
4. ✔️ **Complete Phase 1**: All development tools ready

---

## 🆘 **If You Encounter Issues:**

### **Connection Issues:**
- Verify security group allows your IP
- Check endpoint spelling
- Ensure RDS instances are running

### **Permission Issues:**
- Re-run the GRANT commands
- Verify user was created with \du command
- Check you're connected to correct database

### **DBeaver Issues:**
- **Driver problems**: Go to Database → Driver Manager → PostgreSQL → Download/Update
- **Connection timeout**: Check security group allows your IP (13.43.23.91/32)
- **Authentication failed**: Verify username/password are correct
- **Can't find server**: Double-check the endpoint spelling
- **SSL issues**: In connection settings, go to SSL tab → set SSL mode to "require"

---

**Ready to proceed?** Once you complete these steps, let me know and we'll continue to Step 5 of Phase 1! 