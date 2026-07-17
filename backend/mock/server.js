const jsonServer = require('json-server');
const jwt = require('jsonwebtoken');
const path = require('path');

const server = jsonServer.create();
const router = jsonServer.router(
  path.join(__dirname, 'db.json'),
);

const middlewares = jsonServer.defaults();

const PORT = 3001;
const JWT_SECRET = 'logishield-demo-secret';

server.use(middlewares);
server.use(jsonServer.bodyParser);

server.post('/login', (request, response) => {
  const { email, password } = request.body;

  const database = router.db;
  const user = database
    .get('users')
    .find({
      email,
      password,
    })
    .value();

  if (!user) {
    return response.status(401).json({
      message: 'Invalid email or password',
    });
  }

  const accessToken = jwt.sign(
    {
      sub: user.id,
      email: user.email,
      name: user.name,
    },
    JWT_SECRET,
    {
      expiresIn: '24h',
    },
  );

  return response.json({
    id:Number(user.id),
    name: user.name,
    email: user.email,
    token: accessToken,
  });
});

server.use((request, response, next) => {
  if (
    request.path === '/login' ||
    request.path === '/users'
  ) {
    return next();
  }

  const authorization = request.headers.authorization;

  if (!authorization?.startsWith('Bearer ')) {
    return response.status(401).json({
      message: 'Authorization token is required',
    });
  }

  const token = authorization.substring(7);

  try {
    jwt.verify(token, JWT_SECRET);
    next();
  } catch (_) {
    response.status(401).json({
      message: 'Invalid or expired token',
    });
  }
});

server.use(router);

server.listen(PORT, () => {
  console.log(
    `LogiShield mock server running at http://localhost:${PORT}`,
  );
});