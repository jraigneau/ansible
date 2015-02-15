# ansible
My ansible recipes

**newVM** -> configure an ubuntu VM with monitoring and nice login

```ansible-playbook -i hosts -u -s -K --extra-vars "hosts=watchdog node=26"```
