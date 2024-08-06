const express = require('express');
const userRouter = require('./routes/usersRouter');
const productsRouter = require('./routes/productsRouter');
const ownersRouter = require('./routes/ownersRouter');
const indexRouter = require('./routes/indexRouter');
const appLogger = require('./middlewares/appLogger');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const db = require('./config/mongoose-config');
// const Redis = require('ioredis');
// const upload = require('./config/multer-config')
const app = express();
const PORT = process.env.PORT || 9000;

// Middleware
app.use(cors());
app.set("view engine", "ejs")
require('dotenv').config();
app.use(appLogger);
app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

db.on('connected', () => {
  console.log('Mongoose connected to MongoDB Atlas');
});

db.on('error', (err) => {
  console.error('Mongoose connection error:', err);
});

db.on('disconnected', () => {
  console.log('Mongoose disconnected from MongoDB Atlas');
});


app.use('/',indexRouter);
app.use('/users', userRouter);
app.use('/products', productsRouter);
app.use('/owner', ownersRouter);

// app.post('/upload',upload.single('file'),async(req,res)=>{
//   const name = saltedMd5(req.file.originalname, 'SUPER-S@LT!')
//   const fileName = name + path.extname(req.file.originalname)
//   await app.locals.bucket.file(fileName).createWriteStream().end(req.file.buffer)
//   res.send('done');
//   })

// const redis = new Redis({
//   host: 'redis-11327.c295.ap-southeast-1-1.ec2.redns.redis-cloud.com',
//   port: 11327,
//   password: 'QipNu6LKJUmR6EEmBvGgqeKZVV2M6urw',
// })

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server started on port ${PORT}`);
});
