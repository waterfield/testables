Testables Server Setup
======================

The setup requires one Testables server and one or more Worker servers.

Setting Up a Testables Server
-----------------------------

1. bundle install
2. Install rack based server such as unicorn (sudo gem install unicorn).
3. Install and boot mongodb
4. Run the app (unicorn_rails)

Setting Up a Worker Server
--------------------------

1. bundle install
2. install and boot mongodb
3. bundle exec rake task:run
