#!/usr/bin/perl
package Today;
use strict;
use warnings;
our $VERSION = '1.00';
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(yyyymmdd);


#���Ԍv�Z
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
our $time=($year+1900).sprintf("%02d",$mon+1).sprintf("%02d",$mday);

sub yyyymmdd{
	return $time;
}

1;

__END__
=head1 NAME

Today - ���݂̓��t��YYYYMMDD�ŕԂ������̃��W���[��
�Ȃ񂩂����������W�b�N�����̂߂�ǂ���������

=head1 SYNOPSIS

  use lib "S:/Program/ppm";                #Today.pm��u�����f�B���N�g���w��
  use Today qw(yyyymmdd);                  #�f�t�H���g�ŉ������[�h���Ȃ��̂ł����Ŏw��

  print &yyyymmdd;

=head1 DESCRIPTION

��L�̊T�v�ʂ�ł�

=head2 Attention

����

=head2 EXPORT

�f�t�H���g�ŉ����G�N�X�|�[�g���܂���

=head1 SEE ALSO

���ɂȂ�

=head1 AUTHOR

yamasita 

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by yamasita

 ���쌠�Ƃ��悭�������

=cut
