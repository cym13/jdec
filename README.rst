Description
===========

Jdec is a simple java decompiler wrapper designed to use multiple engines and
automatically support multiple file formats with no frill.

Why ?
=====

Because I often get to reverse engineer applications that are given to me in
many different formats. Got a whole directory of zip files full of APKs?
Throw it to Jdec!

Documentation
=============

::

    Decompile class, jar and war files

    Usage: jdec [-h] FILE...

    Options:
        -h, --help    Print this help and exit.

    Arguments:
        FILE          Files or directory to decompile
                      Supported: class, war, jar, apk, dex, zip

    Notes:
        + cfr and jad are the two decompilers used, in that order
        + dex2jar is required for apk and dex support
        + zip files get unzipped only if containing a decompilable file

Dependencies
============

All dependencies are optional (but it won't do much if you have nothing).

Engines:
    - CFR http://www.benf.org/other/cfr/
    - Jad https://web.archive.org/web/20080214075546/http://www.kpdus.com/jad.html

Archives:
    - unzip http://www.info-zip.org/UnZip.html
    - dex2jar http://sourceforge.net/projects/dex2jar/

License
=======

This program is under the GPLv3 License.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

Contact
=======

::

    Main developper: Cédric Picard
    Email:           cedric.picard@efrei.net
