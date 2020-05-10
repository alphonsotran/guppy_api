# Guppy API

Guppy is a rails api that shortens URL. It exposes two endpoints that allows users to create short version of long links and fetch them.

## Requirements

- Ruby `2.7.1`
- Rails `6.0.3`
- Mongoid `7.0.5`
  (More info: [mongoid docs](https://docs.mongodb.com/mongoid/current/))
- Redis `4.1.4`
  (More info: [redis](https://redis.io/) )

### Before starting

1.  Install Redis

```
 brew install redis
```

2.  Install [Mongoid](https://docs.mongodb.com/mongoid/current/) and MongoDB (community edition)

### Initial setup

1. Install ruby dependencies

   ```
   bundle install
   ```

2. Start redis in a different tab

   ```
   redis-server
   ```

3. Start rails server in another tab

   ```
   rails s
   ```

4. Server runs on `http://localhost:5000`.
