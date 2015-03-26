use chat

var bulk = db.message.initializeUnorderedBulkOp();
bulk.insert({text: "Hello, how are you?", date: "2015-02-25", isRead: true, user:{username: "Gosho", fullname: "Gosho Geshev", website: "www.GoshoGeshata.com"}});
bulk.insert({text: "Fine, you?", date: "2015-02-25", isRead: true, user: {username: "Pesho", fullname: "Pesho Peshev", website: "www.peshoPeshev.bg"}});
bulk.insert({text: "Me too, see you tomorrow.", date: "2015-02-25", isRead: true, user:{username: "Gosho", fullname: "Gosho Geshev", website: "www.GoshoGeshata.com"}});
bulk.execute();