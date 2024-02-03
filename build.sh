#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: build.sh
# Author: Richard Schoen
# Purpose: Create QSHONI library, copies source members and compiles objects
#----------------------------------------------------------------
src_lib="QSHONI"
src_lib_text="QShell on IBM i"
src_file="SOURCE"
src_CCSID="37"
dashes="---------------------------------------------------------------------------"

function cpy_member
{
# ----------------------------------------------------------------
# Copy source member and set source type and text
# ----------------------------------------------------------------
  cur_file=`basename "${cur_file_path}"`
  src_member=`echo "${cur_file^^}" | cut -d'.' -f1`  # Parse PC file name prefix to member name
  src_type=`echo "${cur_file^^}" | cut -d'.' -f2 | sed 's/SRC//'`  # Parse PC file name extenstion to souce type
  system -v "CPYFRMSTMF FROMSTMF('${PWD}/${cur_file_path}') TOMBR('/QSYS.LIB/${src_lib}.LIB/${src_file}.FILE/${src_member}.MBR') MBROPT(*REPLACE) DBFCCSID(*FILE)"
 # Get the object name with its type so we can search Rules.mk for it
  OBJ=$src_member.$src_type
  DIRNAME=$(dirname "$cur_file_path")
  get_member_text
  system -v "CHGPFM FILE(${src_lib}/${src_file}) MBR($src_member) SRCTYPE(${src_type}) TEXT('${src_text}')" 
}
function get_member_text
{
  case $src_type in

    CMD)
      src_text=$(grep "$OBJ: TEXT" "$DIRNAME"/Rules.mk | sed 's/.*= //')
      ;;
    CLLE RPGLE)
      src_text=$(grep -oP "(?<=DCLPRCOPT TEXT\(')[^']+" $cur_file_path)
    DTAARA)
      src_text=$(awk -v RS='\\<TEXT[(]\047(([^\047]|\047\047)+)\047[)]' 'RT{$0=RT; gsub(/^[^\047]+\047|\047[^\047]+$/,""); gsub(/\+\n/,""); print}' $cur_file_path)
      ;;
  esac

}

echo "$dashes"
echo "Starting Build of ${src_lib_text} library ${src_lib}"

# Create library, clear library and create source file 
system -v "CRTLIB ${src_lib} TYPE(*PROD) TEXT('${src_lib_text}')"
system -v "CLRLIB LIB(${src_lib})"
system -v "CRTSRCPF FILE(${src_lib}/${src_file}) RCDLEN(120) CCSID(${src_CCSID})"

# Copy all the source members and set source types
cur_file_path="qcmdsrc/QSHBASH.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHBASHC.PGM.CLLE"              
cpy_member

cur_file_path="qcmdsrc/QSHEXEC.CMDSRC"                
cpy_member

cur_file_path="qcllesrc/QSHEXECC.PGM.CLLE"
cpy_member

cur_file_path="qclsrc/QSHLOGSCAC.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHLOGSCAN.CMDSRC"
cpy_member

cur_file_path="qrpglesrc/QSHLOGSCAR.PGM.RPGLE"
cpy_member

cur_file_path="qcmdsrc/QSHPATH.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHPATHC.PGM.CLLE"
cpy_member

cur_file_path="qrpglesrc/QSHSTDOUTR.PGM.RPGLE"
cpy_member

cur_file_path="qrpglesrc/QSHIFSCHKR.PGM.RPGLE"
cpy_member

cur_file_path="qclsrc/QSHIFSCHKC.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHIFSCHK.CMDSRC"
cpy_member

cur_file_path="qcmdsrc/QSHPYRUN.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHPYRUNC.PGM.CLLE"
cpy_member

cur_file_path="qrpglesrc/QSHDEMO01R.PGM.RPGLE"
cpy_member

cur_file_path="qcmdsrc/QSHQRYTMP.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHQRYTMPC.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHCURL.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHCURLC.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHPORTCHK.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHPORTCHC.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHPORTEND.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHPORTENC.CLLE"
cpy_member

cur_file_path="qcllesrc/QSHSETPROC.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHSETPROF.CMDSRC"
cpy_member

cur_file_path="QSHBASHRC.TXT"
src_text="User .bashrc bash template for Opn Src Pkgs"
cpy_member

cur_file_path="QSHBASHPRF.TXT"
src_text="User .bash_profile bash template for Opn Src Pkgs"
cpy_member

cur_file_path="QSHPROFILE.TXT"
src_text="User QShell .profile template for Opn Src Pkgs"
cpy_member

cur_file_path="qcmdsrc/QSHEXECSRC.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHEXECSCC.CLLE"
cpy_member

cur_file_path="DB2UTIL.CMDSRC"                
cpy_member

cur_file_path="qcllesrc/DB2UTILC.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHPYCALL.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHPYCALLC.PGM.CLLE"
cpy_member

cur_file_path="qcllesrc/QSHPYCALLT.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHGETPARM.CMDSRC"
cpy_member

cur_file_path="qrpglesrc/QSHGETPARR.PGM.RPGLE"
cpy_member

cur_file_path="QSHPHPRUN.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHPHPRUNC.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHCALL.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHCALLC.PGM.CLLE"
cpy_member

cur_file_path="QSHCALLT.PGM.CLLE"
cpy_member

cur_file_path="qcllesrc/QSHCALLT.PGM.CLLE"
cpy_member

cur_file_path="qcmdsrc/QSHCPYSRC.CMDSRC"
cpy_member

cur_file_path="qcllesrc/QSHCPYSRCC.PGM.CLLE"
cpy_member

cur_file_path="qcllesrc/SRCBLDC.PGM.CLLE"
cpy_member

cur_file="README.TXT"
src_text="Read Me Docs on Setup"
cpy_member

cur_file="VERSION.TXT"
src_text="Version Notes"
cpy_member

# Create and run build program
system -q "CRTBNDCL PGM(${src_lib}/SRCBLDC) src_file(${src_lib}/${src_file})"
system -v "CALL PGM(${src_lib}/SRCBLDC)"

echo "${src_lib_text} library ${src_lib} was created and programs compiled."
echo "$dashes"
  
