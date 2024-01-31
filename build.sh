#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: build.sh
# Author: Richard Schoen
# Purpose: Create QSHONI library, copies source members and compiles objects
#----------------------------------------------------------------
SRCLIB="QSHONI"
SRCLIBTEXT="QShell on IBM i"
SRCFILE="SOURCE"
SRCCCSID="37"
dashes="---------------------------------------------------------------------------"

function cpy_member
{
# ----------------------------------------------------------------
# Copy source member and set source type and text
# ----------------------------------------------------------------
  CURFILE=`basename "${CURFILEPATH}"`
  SRCMEMBER=`echo "${CURFILE^^}" | cut -d'.' -f1`  # Parse PC file name prefix to member name
  SRCTYPE=`echo "${CURFILE^^}" | cut -d'.' -f2 | sed 's/SRC//'`  # Parse PC file name extenstion to souce type
  system -v "CPYFRMSTMF FROMSTMF('${PWD}/${CURFILEPATH}') TOMBR('/QSYS.LIB/${SRCLIB}.LIB/${SRCFILE}.FILE/${SRCMEMBER}.MBR') MBROPT(*REPLACE) DBFCCSID(*FILE)"
  PGMOBJ=$SRCMEMBER.$SRCTYPE
  DIRNAME=$(dirname "$CURFILEPATH")
  if [ $SRCTYPE = "CMD" ] ; then SRCTEXT=$(grep "$PGMOBJ: TEXT" "$DIRNAME"/Rules.mk | sed 's/.*= //'); fi
  system -v "CHGPFM FILE(${SRCLIB}/${SRCFILE}) MBR($SRCMEMBER) SRCTYPE(${SRCTYPE}) TEXT('${SRCTEXT}')" 

}

function set_type_and_text
{
# ----------------------------------------------------------------
# Set Source Type and Text
# ----------------------------------------------------------------
  

  
}

echo "$dashes"
echo "Starting Build of ${SRCLIBTEXT} library ${SRCLIB}"

# Create library, clear library and create source file 
system -v "CRTLIB ${SRCLIB} TYPE(*PROD) TEXT('${SRCLIBTEXT}')"
system -v "CLRLIB LIB(${SRCLIB})"
system -v "CRTSRCPF FILE(${SRCLIB}/${SRCFILE}) RCDLEN(120) CCSID(${SRCCCSID})"

# Copy all the source members and set source types
CURFILEPATH="qcmdsrc/QSHBASH.CMDSRC"
SRCTEXT="Run Bash Command via Qshell"
cpy_member

CURFILEPATH="qcllesrc/QSHBASHC.CLLE"              
SRCTEXT="Run Bash Command via Qshell"                            
cpy_member

CURFILEPATH="qcmdsrc/QSHEXEC.CMD"                
SRCTEXT="Run QShell Command Line"                          
cpy_member

CURFILEPATH="qcllesrc/QSHEXECC.CLLE"
SRCTEXT="Run QShell Command Line"
cpy_member

CURFILEPATH="qclsrc/QSHLOGSCAC.CLP"
SRCTEXT="Scan Qshell Log File for Value"  
cpy_member

CURFILEPATH="QSHLOGSCAN.CMD"
SRCTEXT="Scan Qshell Log File for Value"
cpy_member

CURFILEPATH="QSHLOGSCAR.RPGLE"
SRCTEXT="Scan Qshell Log File for Value"
cpy_member

CURFILEPATH="QSHPATH.CMD"
SRCTEXT="Set Open Source Package Path Environment Variables"
cpy_member

CURFILEPATH="qcllesrc/QSHPATHC.CLLE"
SRCTEXT="Set Open Source Package Path Environment Variables"
cpy_member

CURFILEPATH="QSHSTDOUTR.RPGLE"
SRCTEXT="Read and parse stdout log"
cpy_member

CURFILEPATH="QSHIFSCHKR.RPGLE"
SRCTEXT="Check for IFS File Existence"
cpy_member

CURFILEPATH="qclsrc/QSHIFSCHKC.CLP"
SRCTEXT="Check for IFS File Existence"
cpy_member

CURFILEPATH="QSHIFSCHK.CMD"
SRCTEXT="Check for IFS File Existence"
cpy_member

CURFILEPATH="QSHPYRUN.CMD"
SRCTEXT="Run Python Script via Qshell"
cpy_member

CURFILEPATH="qcllesrc/QSHPYRUNC.CLLE"
SRCTEXT="Run Python Script via Qshell"
cpy_member

CURFILEPATH="QSHDEMO01R.RPGLE"
SRCTEXT="Read Outfile STDOUTQSH and display via DSPLY cmd"
cpy_member

CURFILEPATH="QSHQRYTMP.CMD"
SRCTEXT="SQL Query Data to Selected Temp Table with RUNSQL"
cpy_member

CURFILEPATH="qclsrc/QSHQRYTMPC.CLP"
SRCTEXT="SQL Query Data to Selected Temp Table with RUNSQL"
cpy_member

CURFILEPATH="QSHCURL.CMD"
SRCTEXT="Run Curl Command via QShell"
cpy_member

CURFILEPATH="qclsrc/QSHCURLC.CLP"
SRCTEXT="Run Curl Command via QShell"
cpy_member

CURFILEPATH="QSHPORTCHK.CMD"
SRCTEXT="Check for active TCP/IP Local Port"
cpy_member

CURFILEPATH="qclsrc/QSHPORTCHC.CLP"
SRCTEXT="Check for active TCP/IP Local Port"
cpy_member

CURFILEPATH="QSHPORTEND.CMD"
SRCTEXT="End All Jobs for Active TCP/IP Local Port"
cpy_member

CURFILEPATH="qclsrc/QSHPORTENC.CLP"
SRCTEXT="End All Jobs for Active TCP/IP Local Port"
cpy_member

CURFILEPATH="qclsrc/QSHSETPROC.CLP"
SRCTEXT="Set up .profile, .bash_profile and .bashrc files"
cpy_member

CURFILEPATH="QSHSETPROF.CMD"
SRCTEXT="Set up .profile, .bash_profile and .bashrc files"
cpy_member

CURFILEPATH="QSHBASHRC.TXT"
SRCTEXT="User .bashrc bash template for Opn Src Pkgs"
cpy_member

CURFILEPATH="QSHBASHPRF.TXT"
SRCTEXT="User .bash_profile bash template for Opn Src Pkgs"
cpy_member

CURFILEPATH="QSHPROFILE.TXT"
SRCTEXT="User QShell .profile template for Opn Src Pkgs"
cpy_member

CURFILEPATH="QSHEXECSRC.CMD"                
SRCTEXT="Run QShell .sh script from Source File Member"
cpy_member

CURFILEPATH="qcllesrc/QSHEXECSCC.CLLE"
SRCTEXT="Run QShell .sh script from Source File Member"
cpy_member

CURFILEPATH="DB2UTIL.CMD"                
SRCTEXT="Execute db2util Query to IFS Output File via bash"
cpy_member

CURFILEPATH="qcllesrc/DB2UTILC.CLLE"
SRCTEXT="Execute db2util Query to IFS Output File via bash"
cpy_member

CURFILEPATH="QSHPYCALL.CMD"
SRCTEXT="Run Python Script via Qshell and Return Parms"
cpy_member

CURFILEPATH="qcllesrc/QSHPYCALLC.CLLE"
SRCTEXT="Run Python Script via Qshell and Return Parms"
cpy_member

CURFILEPATH="qcllesrc/QSHPYCALLT.CLLE"
SRCTEXT="Test Call to QSHPYCALL"
cpy_member

CURFILEPATH="QSHGETPARM.CMD"
SRCTEXT="Scan Qshell Log File for Parameter Values"
cpy_member

CURFILEPATH="QSHGETPARR.RPGLE"
SRCTEXT="Run Python Script via Qshell and Return Parms"
cpy_member

CURFILEPATH="QSHPHPRUN.CMD"
SRCTEXT="Run PHP Script via QShell"
cpy_member

CURFILEPATH="qcllesrc/QSHPHPRUNC.CLLE"
SRCTEXT="Run PHP Script via QShell"
cpy_member

CURFILEPATH="QSHCALL.CMD"
SRCTEXT="Run QShell Command Line and Return Parms"
cpy_member

CURFILEPATH="qcllesrc/QSHCALLC.CLLE"
SRCTEXT="Run QShell Command Line and Return Parms"
cpy_member

CURFILEPATH="QSHCALLT.CLLE"
SRCTEXT="Test Call to QSHCALL"
cpy_member

CURFILEPATH="qcllesrc/QSHCALLT.CLLE"
SRCTEXT="Test Call to QSHCALL"
cpy_member

CURFILEPATH="QSHCPYSRC.CMD"
SRCTEXT="Copy Source Member to IFS File"
cpy_member

CURFILEPATH="qcllesrc/QSHCPYSRCC.CLLE"
SRCTEXT="Copy Source Member to IFS File"
cpy_member

CURFILEPATH="qclsrc/SRCBLDC.CLP"
SRCTEXT="Build cmds from QSHONI/SOURCE file"   
cpy_member

CURFILE="README.TXT"
SRCTEXT="Read Me Docs on Setup"
cpy_member

CURFILE="VERSION.TXT"
SRCTEXT="Version Notes"
cpy_member

# Create and run build program
system -q "CRTCLPGM PGM(${SRCLIB}/SRCBLDC) SRCFILE(${SRCLIB}/${SRCFILE})"
system -v "CALL PGM(${SRCLIB}/SRCBLDC)"

echo "${SRCLIBTEXT} library ${SRCLIB} was created and programs compiled."
echo "$dashes"
  
