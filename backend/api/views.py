from django.shortcuts import render

# Create your views here.
from django.http import JsonResponse

def ping_view(request):
    return JsonResponse({'message': 'Bonjour mes amis un bon jour commence!'}) 
