# Good Night

## Requirements
==========================================

We would like you to implement a “good night” application to let users track when do they go to bed and when do they wake up.

We require some restful APIS to achieve the following:

1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records over the past week for their friends, ordered by the length of their sleep.

Please implement the model, db migrations, and JSON API.
You can assume that there are only two fields on the users “id” and “name”.

You do not need to implement any user registration API.

You can use any gems you like.

==========================================

## Definition / Why I design like this

1. `Followers`: The users who follow the target user.
2. `Followeds`: The users who are followed by the target user.
3. `Friends`: The same as `Followeds`. I think the `Followeds` can be decided by the target user, but `Followers` cannot be decided by the target user. So, `Followers` can be the unknowns, they are not really `Friends`.
4. `sleep` column of `ClockIn`: The clock in operation with no `sleep` attribute will be hard to be calculate the sleep times for whom turn night into day. So, for more general use cases, I decide to not estimate the meaning by the created time. Instead, **I give the decision to the frontend**.
5. `past week`: I chose the current time minus 7 days as the start point instead of the last Monday to Sunday. I think it is more reasonable for users.
6. The noises of `Sleep Times` calculation: I think that giving `sleep` column to frontend is dangerous. There will be some triggers by mistake. So, I filtered the duplicated *get up records* and *go to bed records*. I reserved *the first get up record* and *the last go to bed record*. You may trigger go to bed early but actually still playing on your phone. The triggers after first get up record are triggered by mistake.

## API Documents

ps. The `user_id` param is an alternative option of auth token for testing.

1. GET /api/v1/clock_ins
    * Get all clock in records of specific user
    * Params:
        - user_id (int)
2. POST /api/v1/clock_ins: 
    * Add a clock in record of specific user
    * Params:
        - user_id (int)
3. POST /api/v1/follows:
    * Follow another user
    * Params:
        - user_id (int)
        - follow_id (int): the target person you want to follow
4. DELETE /api/v1/unfollows:
    * Unfollow another user
    * Params:
        - user_id (int)
        - unfollow_id (int): the target person you want to unfollow
5. GET /api/v1/sleep_ranking:
    * Get a sleeping time ranking list of your friends(your followed list, not including your followers)
    * Params:
        - user_id (int)

You can test the APIs through the Postman by the postman collection examples(The file named `Good Night.postman_collection.json` at the root of project).

## Testing

I only implemented the testing of sleep time calculation, because I think the sleep time calculation logic is complex enough to be tested.

1. `$ RAILS_ENV=test bin/rails db:prepare`
2. `$ RAILS_ENV=test bin/rails test`

### Test at development environment

You can import the mock data at the development environment from fixtures by the instructions below.

1. `$ bin/rails db:prepare`
2. `$ bin/rails db:fixtures:load`
3. `$ bin/rails console`
4. Test as you wish