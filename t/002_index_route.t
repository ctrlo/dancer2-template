use Test::More tests => 2;
use strict;
use warnings;

# the order is important
use APPNAME;
use Dancer2::Test apps => ['APPNAME'];

route_exists [GET => '/'], 'a route handler is defined for /';
response_status_is ['GET' => '/'], 200, 'response status is 200 for /';
