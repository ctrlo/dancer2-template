=pod
APPNAME
Copyright (C) 2014 Ctrl O Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=cut

package APPNAME;
use Dancer2;

our $VERSION = '0.1';

hook before => sub {

    # Static content
    return if request->uri =~ m!^/(error|js|css|login|images|fonts)!;
    return if param 'error';

    session 'messages' => ();
};

get '/' => sub {
    my $output  = template 'index' => {
        messages    => session('messages'),
        user        => var('user'),
        page        => 'index'
    };
    session 'messages' => [];
    $output;
};

any '/view' => sub {

    my $output  = template 'view' => {
        messages    => session('messages'),
        user        => var('user'),
        page        => 'view'
    };
    session 'messages' => [];
    $output;
};


sub forwardHome {
    if (my $message = shift)
    {
        my $text = ( values %$message )[0];
        my $type = ( keys %$message )[0];

        messageAdd($message);
    }
    my $page = shift || '';
    redirect "/$page";
}

sub messageAdd($) {
    my $message = shift;
    my $text    = ( values %$message )[0];
    my $type    = ( keys %$message )[0];
    my $msgs    = session 'messages';
    push @$msgs, { text => $text, type => $type };
    session 'messages' => $msgs;
}

true;
