## Description
This is Windows batch that aims to help people running Particl Desktop on Windows. When application for the first time, the Particl Desktop downloads the latest version of the Particl Core and starts it. Next the Particl Core will attempt to sync the blockchain from the dscratch/genesis. to PartThe Particl Core in its turn will The Windows Defender  It adds the Particl Core and Particl Desktop folders (including their corresponding executables) to the Windows Defender exclussion list. 

In addition, it adds a few rules to the Windows Firewall that allow the in/out bound traffic towards Particl Core and Particl Desktop related services.

## Usage instructions
1. Download a Particl Desktop build in compressed file (.zip) form from here:   
https://github.com/particl/particl-desktop/releases
2. Extract the Particl Desktop files to some folder but do not start it yet..
3. Download the addDefenderRule.bat and place it also in that folder.
4. Run the addDefenderRule.bat by double clicking the file.
5. Execute/run the "Particl Desktop.exe" for the first time. 
