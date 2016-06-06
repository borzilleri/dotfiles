#!/bin/bash
docker_ps_short () {
	docker ps $@ | awk '
	function join(array, sep, result, i) {
		if (sep == "")
			sep = " "
		else if (sep == SUBSEP) # magic value
			sep = ""
		result = ""
		for( i in array ) {
			if( result != "" )
				result = result sep
			result = result array[i]
		}
		return result
	}

	function get_ports(s) {
		port_re = "[[:digit:]]+->[[:digit:]]+/(tcp|udp)"
		num_ports = split(s, ports_list, ",")
		for( i in ports_list ) {
			found = match(ports_list[i], port_re)
			if( found ) {
				port_spec = substr(ports_list[i], RSTART, RLENGTH)
				sub(/->/, "/", port_spec)
				split(port_spec, port_spec_list, "/")
				if( port_spec_list[1] != port_spec_list[2] )
					port_spec_list[1] = port_spec_list[1] "->" port_spec_list[2]
				ports_list[i] = port_spec_list[1] "/" port_spec_list[3]
			}
			else
				delete ports_list[i]
		}
		return join(ports_list, ", ")
	}

	BEGIN { FS = "  +" } ;
	NR == 1 { printf "%s\t%s\t%s\t%s\n", $7, $2, $5, $6 } ;
	NR > 1 {
		id = $1; image = $2; cmd = $3; created = $4;
		status = $5; ports = $6; names = $7;
		split(status, status_a, " ")
		ports_s = get_ports(ports)
		printf "%s\t%s\t%s\t%s\n", names, image, status_a[1], ports_s
	}' | column -t -s $'\t' -c 80 | sort
}
alias dps=docker_ps_short
