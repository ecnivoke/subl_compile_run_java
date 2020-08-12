import sublime
import sublime_plugin
import subprocess
import os


class Compile_javaCommand(sublime_plugin.TextCommand):
	def run(self, edit):

		folder = os.path.split(self.view.file_name())[0]
		file = os.path.split(self.view.file_name())[1]
		dir_path = os.path.dirname(os.path.realpath(__file__))
		call = folder.split("src\\")[1] + "." + file.split(".java")[0]

		if file.find('.java') > -1:
			file = file.split('.java')[0]
			subprocess.Popen([dir_path + '/compiler.bat', folder, call, file])

		else:
			print('"' + file + '" is not a java file')
