db = db.getSiblingDB('nodebb')
db.createUser(
  {
    user: "nodebb",
    pwd: "nodebbpassword",
    roles: [
      { role: "readWrite", db: "nodebb" },
      { role: "clusterMonitor", db: "admin" }
    ]
  }
)
