#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

opts="${opts} reload configtest"

HELMA_CONFIG=/etc/helma.conf
JAVA_BIN=`java-config -J`

depend() {
    need net
    use dns logger netmount
    after sshd
}

configtest() {
    ebegin "Checking Helma Configuration"
    checkconfig
    eend $?
}

checkconfig() {

    # Check for existence of needed config file and source it
    if [ -r $HELMA_CONFIG ]; then
        source $HELMA_CONFIG
    else
        echo "Can't read config file $HELMA_CONFIG"
        return 6
    fi

    # Check for missing files and directories
    if [ ! -x $JAVA_BIN ]; then
        echo "Config error: JAVA_BIN $JAVA_BIN not found or not executable"
        return 5
    fi
    if [ ! -r $HELMA_INSTALL/launcher.jar ]; then
        echo "Config error: $HELMA_INSTALL/launcher.jar not found or not readable"
        return 5
    fi
    if [ ! -d $HELMA_HOME ]; then
        echo "Config error: HELMA_HOME $HELMA_HOME not found"
        return 5
    fi

	RUN_CMD="sudo -u $HELMA_USER $JAVA_BIN"
	RUN_ARGS="$JAVA_OPTS -jar $HELMA_INSTALL/launcher.jar -h $HELMA_HOME $HELMA_ARGS"
}


start() {
    checkconfig || return 1
    ebegin "Starting helma"

    if [ -f $HELMA_PID ]; then
        echo "Helma already running"
        eend 1
    fi

    touch $HELMA_HOME/server.properties
    touch $HELMA_HOME/apps.properties

	# cd $HELMA_HOME
    nohup $RUN_CMD $RUN_ARGS > $HELMA_LOG 2>&1 &
    echo $! > $HELMA_PID

    eend 0
}


stop() {
    checkconfig || return 1
    ebegin "Stopping helma"

    if [ ! -f $HELMA_PID ]; then
    	echo "Helma not running"
	    eend 1
    fi

    PID=`cat $HELMA_PID 2>/dev/null`
    kill $PID 2>/dev/null; sleep 2; kill -9 $PID 2>/dev/null
    rm -f $HELMA_PID

    eend 0
}

reload() {
    if ! service_started "${myservice}" ; then
        eerror "Helma is not running! Please start it before trying to reload it."
    else
        checkconfig || return 1
        ebegin "Reloading helma"

        touch $HELMA_HOME/server.properties
        touch $HELMA_HOME/apps.properties

        eend 0
    fi
}

