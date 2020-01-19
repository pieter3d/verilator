#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

scenarios(simulator => 1);

top_filename("t/t_func_dotted.v");
my $out_filename = "$Self->{obj_dir}/V$Self->{name}.xml";

compile(
    v_flags2 => ['+define+ATTRIBUTES', '+define+USE_INLINE_MID',],
    );

if ($Self->{vlt_all}) {
    file_grep("$out_filename", qr/\<instance fl="d86" loc="\d+,\d+,\d+,\d+" name="t.ma0.mb0" defName="mb" origName="mb0"\/\>/i);
    file_grep("$out_filename", qr/\<module fl="d98" loc="\d+,\d+,\d+,\d+" name="mb" origName="mb"\>/i);
}

execute(
    check_finished => 1,
    );

ok(1);
1;
