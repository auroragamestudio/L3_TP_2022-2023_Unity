using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

[ExecuteInEditMode]
public class Controller : MonoBehaviour
{
    public Color shadowColor = Color.black;
    public GameObject _firePit;
    public Light _sunlight;
    public Material _titleMaterial;
    public float _rotateSpeed = 1.0f;
    
    private bool _jourNuit;
   

    // Update is called once per frame
    void Update()
    {
        //TODO Mettre à jour la variable globale des shaders "_CelShadowColor" avec la couleur shadowColor 
        

        // TODO "Uploader" la matrice de rotation dans le shader du titre 3D
        
        
        if (Input.GetKeyDown(KeyCode.N))
        {
            _jourNuit = !_jourNuit;
            
            // Activate fire pit gameobject
            _firePit.SetActive(_jourNuit);
            
            // Update sun light intensity
            _sunlight.intensity = _jourNuit?0.2f:1.0f;
            
            //TODO Mettre à jour les variables Reflection intensity et ambient Intensity en fonction du mode

            
        }
        
    }
}
