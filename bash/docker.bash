#!/bin/bash
docker_ps_short () {
	docker ps | awk '
	function join(array, start, end, sep, result, i) {
		if (sep == "")
			sep = " "
		else if (sep == SUBSEP) # magic value
			sep = ""
		result = array[start]
		for (i = start + 1; i <= end; i++)
			result = result sep array[i]
		return result
	}

	function get_ports(s) {
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
		return join(ports_list, 1, num_ports, ",")
	}

	BEGIN { FS = "  +" } ; {
		#port_re = "([[:digit:]]\.?){4}:[[:digit:]]+->[[:digit:]]+/(tcp|udp)"
		port_re = "[[:digit:]]+->[[:digit:]]+/(tcp|udp)"
		id = $1; image = $2; cmd = $3; created = $4; status = $5; ports = $6; names = $7
		split(status, status_a, " ")
		if( ports == "PORTS" )
			ports_s = ports
		else {
			ports_s = get_ports(ports)
		}
		printf "%s\t%s\t%s\t%s\n", names, image, status_a[1], ports_s
	}' | column -t
}
alias dps=docker_ps_short